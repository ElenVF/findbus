<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "routes".
 *
 * @property int $id
 * @property string $bus_number
 *
 * @property Schedule[] $schedules
 */
class Routes extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'routes';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['bus_number'], 'required'],
            [['bus_number'], 'string', 'max' => 10],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'bus_number' => 'Bus Number',
        ];
    }

    /**
     * Gets query for [[Schedules]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getSchedules()
    {
        return $this->hasMany(Schedule::class, ['route_id' => 'id']);
    }
}
