package com.wighawag.view.sprite;
import com.wighawag.core.PlacementComponent;
import com.wighawag.asset.renderer.NMEDrawingContext;
import com.wighawag.asset.spritesheet.Sprite;
using com.wighawag.asset.spritesheet.SpriteUtils;
import com.wighawag.asset.load.Batch;
import com.wighawag.view.EntityView;
import com.wighawag.core.StateComponent;
import com.wighawag.core.AssetComponent;
class BasicSpriteView implements EntityView<NMEDrawingContext>{


    @owner
    private var placementComponent : PlacementComponent;

    @entityType
    private var assetComponent : AssetComponent;

    @owner
    private var stateComponent : StateComponent;

    private var sprites : Batch<Sprite>;

    public function new(sprites : Batch<Sprite>) {
        this.sprites = sprites;
    }

    public function initialise():Void{

    }

    public function draw(context:NMEDrawingContext):Void {
        var sprite = sprites.get(assetComponent.assetId);
        if (assetComponent.scale){
            sprite.drawScaled(context, stateComponent.state, stateComponent.elapsedTime, Std.int(placementComponent.x), Std.int(placementComponent.y), Std.int(placementComponent.width), Std.int(placementComponent.height));
        }else if (assetComponent.fillVertically && assetComponent.fillVertically){
            sprite.fill(context, stateComponent.state, stateComponent.elapsedTime, Std.int(placementComponent.x), Std.int(placementComponent.y), Std.int(placementComponent.width), Std.int(placementComponent.height));
        }else if (assetComponent.fillHorizontally){
            sprite.fillHorizontally(context, stateComponent.state, stateComponent.elapsedTime, Std.int(placementComponent.x), Std.int(placementComponent.y), Std.int(placementComponent.width));
        }else if (assetComponent.fillVertically){
            sprite.fillVertically(context, stateComponent.state, stateComponent.elapsedTime, Std.int(placementComponent.x), Std.int(placementComponent.y), Std.int(placementComponent.height));
        }else{
            sprite.draw(context, stateComponent.state, stateComponent.elapsedTime, Std.int(placementComponent.x), Std.int(placementComponent.y));
        }

    }


    public function match():Bool {
        return true;
    }

    public function onAssociated():Void {
    }


}
