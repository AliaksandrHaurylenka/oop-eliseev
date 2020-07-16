<?php

namespace lesson04\example02\demo03\cart;

class Cart
{
    private $items = [];

    public function getItems()
    {
        $this->items = isset($_SESSION['cart']) ? unserialize($_SESSION['cart']) : [];
        return $this->items;
    }

    public function add($id, $count)
    {
        $this->items = isset($_SESSION['cart']) ? unserialize($_SESSION['cart']) : [];
        $current = isset($this->items[$id]) ? $this->items[$id] : 0; // если в сессии уже есть количество товаров с таким id, то
        $this->items[$id] = $current + $count; // прибавляем еще добавленное количество товаров
        $_SESSION['cart'] = serialize($this->items);
    }

    public function remove($id)
    {
        $this->items = isset($_SESSION['cart']) ? unserialize($_SESSION['cart']) : [];
        if (array_key_exists($id, $this->items)) {
            unset($this->items[$id]);
        }
        $_SESSION['cart'] = serialize($this->items);
    }

    public function clear()
    {
        $this->items = [];
        $_SESSION['cart'] = serialize($this->items);
    }
} 