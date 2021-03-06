<?php

use yii\helpers\Html;
use yii\grid\GridView;
use app\helpers\EmployeeHelper;
use app\models\Employee;

/* @var $this yii\web\View */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Employees';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="employee-index">

    <h1><?= Html::encode($this->title) ?></h1>

    <p>
        <?= Html::a('Create Employee', ['create'], ['class' => 'btn btn-success']) ?>
    </p>


    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            'id',
            'first_name',
            'last_name',
            'address',
            'email:email',
            [
                'attribute' => 'status',
                'filter' => EmployeeHelper::getStatusList(),
                'value' => function (Employee $employee) {
                    return EmployeeHelper::getStatusName($employee->status);
                },
            ],

            ['class' => 'yii\grid\ActionColumn'],
        ],
    ]); ?>


</div>
