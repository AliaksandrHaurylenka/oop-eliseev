<?php

namespace lesson04\example02\demo07\cart\storage;

class SessionStorage implements StorageInterface
{
    private $key;

    public function __construct($key)
    {
        $this->key = $key;
    }

    public function load()
    {
        return isset($_SESSION[$this->key]) ? unserialize($_SESSION[$this->key]) : [];
    }

    public function save(array $items)
    {
        $_SESSION[$this->key] = serialize($items);
    }
}