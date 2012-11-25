package com.wighawag.view;

import com.wighawag.system.EntityComponent;
import flash.display.BitmapData;

class GraphicsComponent implements EntityComponent{

    public function new(bitmapData : BitmapData) {
        this.bitmapData = bitmapData;
    }

    public function initialise():Void{

    }

    public var bitmapData(default, null) : BitmapData;
}
