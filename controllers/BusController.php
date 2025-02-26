<?php

namespace app\controllers;

use app\models\BusSearch;
use app\models\Routes;
use app\models\Stops;
use app\models\Schedule;
use app\models\Way;
use Yii;

class BusController extends \yii\web\Controller
{
    public function actionIndex()
    {
        $model = new BusSearch();

        return $this->render('index', [
            'model' => $model,
        ]);
    }
    public function actionFindBus($from, $to)
    {
        Yii::$app->response->format = Yii\web\Response::FORMAT_JSON;

        // Находим остановки по названию
        $fromStop = Stops::find()->where(['name' => $from])->one();
        $toStop = Stops::find()->where(['name' => $to])->one();

        if (!$fromStop || !$toStop) {
            return [
                'success' => false,
                'message' => 'Остановка не найдена.'
            ];
        }

        // Получаем маршруты, которые проходят через обе остановки
        $routes = Routes::find()
            ->joinWith('schedules')
            ->where(['schedule.stop_id' => $fromStop->id])
            ->orWhere(['schedule.stop_id' => $toStop->id])
            ->groupBy('routes.id')
            ->having('COUNT(DISTINCT schedule.stop_id) = 2')
            ->andHaving('MIN(CASE WHEN schedule.stop_id = :fromStopId THEN schedule.time END) < MIN(CASE WHEN schedule.stop_id = :toStopId THEN schedule.time END)', [
                ':fromStopId' => $fromStop->id,
                ':toStopId' => $toStop->id,
            ])
            ->all();


        if (empty($routes)) {
            return [
                'success' => false,
                'message' => 'Маршруты не найдены.'
            ];
        }

        $buses = [];
        foreach ($routes as $route) {
            // Получаем следующие прибытия для каждого маршрута на конкретной остановке
            $nextArrivals = Schedule::find()
                ->select('time')
                ->where(['route_id' => $route->id])
                ->andWhere(['stop_id' => $fromStop->id]) // Указываем конкретную остановку
                ->andWhere(['>=', 'time', date('H:i:s')]) // Фильтруем по времени
                ->orderBy('time')
                ->limit(3)
                ->column();

            $buses[] = [
                'route' => "Автобус №{$route->bus_number} в сторону ост. {$toStop->name}",
                'next_arrivals' => $nextArrivals,
            ];
        }

        return [
            'success' => true,
            'from' => $fromStop->name,
            'to' => $toStop->name,
            'buses' => $buses,
        ];
    }









    public function actionUpdateRoute($id)
    {
        $model = $this->findModel($id);
        $existingStops = Way::find()->where(['routes_id' => $model->id])->all();
        $existingStopIds = array_map(function ($stop) {
            return $stop->stops_id;
        }, $existingStops);

        if (Yii::$app->request->isPut) {
            $model->load(Yii::$app->request->bodyParams, ''); // Загружаем данные из тела запроса

            if ($model->save()) {
                // Логика для добавления промежуточной остановки
                $newStopId = Yii::$app->request->post('new_stop_id');
                if ($newStopId) {
                    $newStop = new Way();
                    $newStop->routes_id = $model->id;
                    $newStop->stops_id = $newStopId;
                    $newStop->route_order = count($existingStops) + 1;
                    $newStop->save();
                }

                return $this->asJson(['success' => true, 'data' => $model]);
            } else {
                return $this->asJson(['error' => 'Failed to update route.', 'details' => $model->getErrors()]);
            }
        }


        $availableStops = Stops::find()->where(['NOT IN', 'id', $existingStopIds])->all();

        return $this->render('update-route', [
            'model' => $model,
            'availableStops' => $availableStops,
            'existingStops' => $existingStops,
        ]);
    }
}
