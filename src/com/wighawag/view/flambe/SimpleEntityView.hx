package com.wighawag.view.flambe;

import com.wighawag.core.PlacementComponent;
import flambe.display.Texture;
import flambe.platform.flash.FlashTexture;
import com.wighawag.system.Entity;
import flambe.display.DrawingContext;
import com.wighawag.view.EntityView;

class SimpleEntityView implements EntityView<DrawingContext>{

    @owner
    private var placementComponent : PlacementComponent;

    @owner
    private var graphicsComponent : GraphicsComponent;

    private var texture : Texture;

    public function new() {
    }

    public function initialise():Void{

    }

    public function draw(context:DrawingContext):Void {
        var totalWidth = 0;
        var totalHeight = 0;
        var maxWidth = placementComponent.width;
        var maxHeight = placementComponent.height;
        while(totalHeight < maxHeight){
            totalWidth = 0;
            while(totalWidth < maxWidth){
                context.drawImage(texture,placementComponent.x + totalWidth, placementComponent.y + totalHeight);
                totalWidth += texture.width;
            }
            totalHeight += texture.height   ;
        }
    }

    public function match():Bool {
        return true;
    }

    public function onAssociated():Void {
        texture = new FlashTexture(graphicsComponent.bitmapData);
    }


}
