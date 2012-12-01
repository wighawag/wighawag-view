package com.wighawag.view.sprite;
import com.wighawag.core.PlacementComponent;
import com.wighawag.asset.renderer.NMEDrawingContext;
import com.wighawag.asset.spritesheet.Sprite;
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
        var animation = sprite.get(stateComponent.state);
        var frame = animation.get(stateComponent.elapsedTime);
        var texture = frame.texture;

        if (assetComponent.fillHorizontally || assetComponent.fillVertically){
            // TODO switch betwwen vertical/horizontal or both filling

            var totalWidth = 0;
            var totalHeight = 0;
            var maxWidth = Std.int(placementComponent.width);
            var maxHeight = Std.int(placementComponent.height);
            while(totalHeight < maxHeight){
                totalWidth = 0;
                while(totalWidth < maxWidth){
                    context.drawTexture(
                        texture.bitmapAsset,
                        texture.x,
                        texture.y,
                        texture.width,
                        texture.height,
                        Std.int(placementComponent.x) + totalWidth - frame.x - texture.frameX,
                        Std.int(placementComponent.y) + totalHeight - frame.y - texture.frameY
                    );
                    totalWidth += texture.width;
                }
                totalHeight += texture.height   ;
            }
        }else{

            var scaleX = 1.0;
            var scaleY = 1.0;
            if (assetComponent.scale){
                scaleX = placementComponent.width / texture.width;
                scaleY = placementComponent.height / texture.height;
            }

            context.drawScaledTexture(
                texture.bitmapAsset,
                texture.x,
                texture.y,
                texture.width,
                texture.height,
                Std.int(placementComponent.x - (frame.x + texture.frameX) * scaleX),
                Std.int(placementComponent.y - (frame.y + texture.frameY) * scaleY),
                scaleX,
                scaleY
            );
        }

    }


    public function match():Bool {
        return true;
    }

    public function onAssociated():Void {
    }


}
