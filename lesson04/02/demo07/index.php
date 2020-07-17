<?php

use lesson04\example02\demo07\cart\Cart;
use lesson04\example02\demo07\cart\storage\SessionStorage;
use lesson04\example02\demo07\cart\storage\YiiDbStorage;
use lesson04\example02\demo07\cart\storage\YiiSessionStorage;

require_once __DIR__ . '/vendor/autoload.php';

// if ($user = Yii::$app->user->identity) {
//     $storage = new YiiDbStorage($user->getId());
// } else {
//     $storage = new YiiSessionStorage('cart');
// }

$storage = new SessionStorage('cart');
$cart = new Cart($storage);

$cart->add(5, 6, 100);

echo $cart->getCost() . PHP_EOL;


$storage1 = new SessionStorage('cart1');
$cart1 = new Cart($storage1);

$cart1->add(5, 6, 200);

echo $cart1->getCost() . PHP_EOL;