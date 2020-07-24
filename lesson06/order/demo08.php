<?php

namespace lesson06\order\demo08;

use DateTime;
use yii\db\ActiveRecord;
use Yii;
use yii\mail\MailerInterface;
use yii\web\Controller;

/**
 * @property $id
 * @property $updated_at
 * @property $paid_at
 * @property $sent_at
 * @property $email
 * @property $status
 */
class Order extends ActiveRecord
{
    const STATUS_NEW = 0;
    const STATUS_PAID = 1;
    const STATUS_SENT = 2;

    public function pay(DateTime $date)
    {
        if ($this->status === self::STATUS_PAID) {
            throw new \DomainException('Заказ уже оплачен');
        }
        $this->status = self::STATUS_PAID;
        $this->paid_at = $date->getTimestamp();
        $this->updated_at = time();
    }

    public function send(DateTime $date)
    {
        if ($this->status === self::STATUS_SENT) {
            throw new \DomainException('Заказ уже отправлен');
        }
        $this->status = self::STATUS_SENT;
        $this->sent_at = $date->getTimestamp();
        $this->updated_at = time();
    }
}

class NotFoundException extends \RuntimeException {

}

class OrderRepository
{
    public function find($id) {
        if (!$order = Order::findOne($id)) {
            throw new NotFoundException('Заказ не найден');
        }
        return $order;
    }

    public function save(Order $order) {
        if (!$order->save()) {
            throw new \RuntimeException('Ошибка сохранения');
        }
    }
}

class OrderService
{
    private $repository;
    private $mailer;

    public function __construct(OrderRepository $repository, MailerInterface $mailer)
    {
        $this->repository = $repository;
        $this->mailer = $mailer;
    }

    public function pay($id, DateTime $date)
    {
        $order = $this->repository->find($id);
        $order->pay($date);
        $this->repository->save($order);
        $this->mailer->compose()
            ->setSubject('Ваш заказ оплачен!')
            ->setTo($order->email)
            ->send();
    }
}

#######################################

class OrderWebController extends \yii\web\Controller
{
    private $service;

    public function __construct($id, $module, OrderService $service, $config = [])
    {
        $this->service = $service;
        parent::__construct($id, $module, $config = []);
    }

    public function actionPay($id)
    {
        try {
            $this->service->pay($id, new DateTime());
        } catch (\DomainException $e) {
            Yii::$app->session->setFlash('error', $e->getMessage());
        }
        return $this->redirect(['view', 'id' => $id]);
    }
}

class OrderRestController extends \yii\rest\Controller
{
    private $service;

    public function __construct($id, $module, OrderService $service, $config = [])
    {
        $this->service = $service;
        parent::__construct($id, $module, $config = []);
    }

    public function actionPay($id)
    {
        $this->service->pay($id, new DateTime());
        return $this->redirect(['view', 'id' => $id]);
    }
}