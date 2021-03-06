<?php

namespace lesson03\example1\demo12;

class Base
{
    private $third = 'third_1';

    public function first()
    {
        return 'first + ' . $this->second();
    }

    protected function second()
    {
        return $this->third;
    }
}

class Sub extends Base
{
    private $third = 'third_2';
}

$base = new Base();

echo $base->first() . PHP_EOL;

$base = new Sub();

echo $base->first() . PHP_EOL;
