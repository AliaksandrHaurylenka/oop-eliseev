<?php

use lesson04\example02\demo03\cart\Cart;

require_once __DIR__ . '/vendor/autoload.php';

echo 'Create cart' . PHP_EOL;

$cart = new Cart();
var_dump($cart->getItems());

echo 'Add item' . PHP_EOL;

$cart->add(5, 6);
$cart->add(5, 3);
$cart->add(7, 12);
var_dump($cart->getItems());

echo 'Remove item' . PHP_EOL;

$cart->remove(5);
var_dump($cart->getItems());

echo 'Clear' . PHP_EOL;

$cart->clear();
var_dump($cart->getItems());