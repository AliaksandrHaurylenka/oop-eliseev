<?php

namespace demo06\graphics;

class Canvas {
    public function paint(Point $point) {
        list($x, $y, $z) = $point->getPointCoordinates();
        echo "[x = $x; y = $y; z = $z]\n";
    }
}