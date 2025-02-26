<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "schedule".
 *
 * @property int $id
 * @property int|null $route_id
 * @property int|null $stop_id
 * @property string $time
 *
 * @property Routes $route
 * @property Stops $stop
 */
class Schedule extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'schedule';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['route_id', 'stop_id'], 'default', 'value' => null],
            [['route_id', 'stop_id'], 'integer'],
            [['time'], 'required'],
            [['time'], 'safe'],
            [['route_id'], 'exist', 'skipOnError' => true, 'targetClass' => Routes::class, 'targetAttribute' => ['route_id' => 'id']],
            [['stop_id'], 'exist', 'skipOnError' => true, 'targetClass' => Stops::class, 'targetAttribute' => ['stop_id' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'route_id' => 'Route ID',
            'stop_id' => 'Stop ID',
            'time' => 'Time',
        ];
    }

    /**
     * Gets query for [[Route]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getRoute()
    {
        return $this->hasOne(Routes::class, ['id' => 'route_id']);
    }

    /**
     * Gets query for [[Stop]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getStop()
    {
        return $this->hasOne(Stops::class, ['id' => 'stop_id']);
    }
}
