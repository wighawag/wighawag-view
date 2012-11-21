package com.wighawag.view.sprite;
import com.wighawag.core.PlacementComponent;
import com.wighawag.asset.renderer.SpriteDrawingContext;
import com.wighawag.view.EntityView;
import com.wighawag.core.StateComponent;
import com.wighawag.core.AssetComponent;
class BasicSpriteView implements EntityView<SpriteDrawingContext>{


    @owner
    private var placementComponent : PlacementComponent;

    @entityType
    private var assetComponent : AssetComponent;

    @owner
    private var stateComponent : StateComponent;

    public function new() {
    }

    public function draw(context:SpriteDrawingContext):Void {

        if (assetComponent.fillHorizontally || assetComponent.fillVertically){
            // TODO switch betwwen vertical/horizontal both filling
            context.fillSprite(assetComponent.assetId, stateComponent.state, stateComponent.elapsedTime, Std.int(placementComponent.x), Std.int(placementComponent.y), Std.int(placementComponent.width), Std.int(placementComponent.height));
        }else{
            context.drawSprite(assetComponent.assetId, stateComponent.state, stateComponent.elapsedTime, Std.int(placementComponent.x), Std.int(placementComponent.y));
        }

    }

    public function match():Bool {
        return true;
    }

    public function onAssociated():Void {
    }


}
