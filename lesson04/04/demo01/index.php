<?php

namespace lesson04\example04\demo01;

use lesson04\example04\cart\storage\SessionStorage;
use lesson04\example04\cart\Cart;
use lesson04\example04\cart\cost\SimpleCost;

require_once __DIR__ . '/vendor/autoload.php';

$cart = new Cart(new SessionStorage('cart'), new SimpleCost());

$cart->add(1, 3, 100);
var_dump($cart->getItems());
var_dump($cart->getCost());
 