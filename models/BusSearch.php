<?php

namespace app\models;

use Yii;


class BusSearch extends \yii\db\ActiveRecord
{

    public $from;
    public $to;
  

    public function rules()
    {
        return [
            [['from', 'to'], 'required'],
        ];
    }

    public function attributeLabels()
    {
        return [
            'from' => 'Начальная остановка',
            'to' => 'Конечная остановка',
        ];
    }
}
