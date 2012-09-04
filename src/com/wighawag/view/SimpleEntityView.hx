package com.wighawag.view;

import com.wighawag.core.PositionComponent;
import flambe.display.Texture;
import flambe.platform.flash.FlashTexture;
import com.wighawag.system.Entity;
import flambe.display.DrawingContext;

class SimpleEntityView implements EntityView{

    @owner
    private var positionComponent : PositionComponent;

    @owner
    private var graphicsComponent : GraphicsComponent;

    private var texture : Texture;

    public function new() {
    }

    public function draw(context:DrawingContext):Void {
        context.drawImage(texture,positionComponent.x,positionComponent.y);
    }

    public function match():Bool {
        return true;
    }

    public function onAssociated():Void {
        texture = new FlashTexture(graphicsComponent.bitmapData);
    }


}
