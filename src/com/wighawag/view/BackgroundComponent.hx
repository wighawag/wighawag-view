package com.wighawag.view;

import flambe.platform.flash.FlashTexture;
import flambe.display.Texture;
import nme.display.BitmapData;
import flambe.display.DrawingContext;
import com.wighawag.system.ModelComponent;

class BackgroundComponent implements ModelComponent{

    private var texture : Texture;

    public function new(bitmapData : BitmapData) {
        texture = new FlashTexture(bitmapData);
    }

    public function draw(context : DrawingContext) : Void{
        context.drawImage(texture,0,0);
    }
}
