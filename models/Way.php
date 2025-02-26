<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "way".
 *
 * @property int $id
 * @property int $routes_id
 * @property int $stops_id
 * @property int $route_order
 * @property string|null $name
 *
 * @property Routes $routes
 * @property Stops $stops
 */
class Way extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'way';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['id', 'routes_id', 'stops_id', 'route_order'], 'required'],
            [['id', 'routes_id', 'stops_id', 'route_order'], 'default', 'value' => null],
            [['id', 'routes_id', 'stops_id', 'route_order'], 'integer'],
            [['name'], 'string', 'max' => 100],
            [['id'], 'unique'],
            [['routes_id'], 'exist', 'skipOnError' => true, 'targetClass' => Routes::class, 'targetAttribute' => ['routes_id' => 'id']],
            [['stops_id'], 'exist', 'skipOnError' => true, 'targetClass' => Stops::class, 'targetAttribute' => ['stops_id' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'routes_id' => 'Routes ID',
            'stops_id' => 'Stops ID',
            'route_order' => 'Route Order',
            'name' => 'Name',
        ];
    }

    /**
     * Gets query for [[Routes]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getRoutes()
    {
        return $this->hasOne(Routes::class, ['id' => 'routes_id']);
    }

    /**
     * Gets query for [[Stops]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getStops()
    {
        return $this->hasOne(Stops::class, ['id' => 'stops_id']);
    }
}
