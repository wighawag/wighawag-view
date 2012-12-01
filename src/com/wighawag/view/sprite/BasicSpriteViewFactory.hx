package com.wighawag.view.sprite;
import com.wighawag.system.Entity;
import com.wighawag.view.EntityView;
import com.wighawag.view.EntityViewFactory;
import com.wighawag.asset.spritesheet.Sprite;
import com.wighawag.asset.renderer.NMEDrawingContext;
import com.wighawag.asset.load.Batch;

class BasicSpriteViewFactory  implements EntityViewFactory<NMEDrawingContext>{

    private var sprites : Batch<Sprite>;

    public function new(sprites : Batch<Sprite>) {
        this.sprites = sprites;
    }

    public function get(entity:Entity):EntityView<NMEDrawingContext> {

        var view : EntityView<NMEDrawingContext> = new BasicSpriteView(sprites);

        var accessClass = view.attach(entity);
        if (accessClass != null){
            var success = view.attachEntity(entity);
            if (success && view.match()){
                view.onAssociated();
                return view;
            }
        }
        return null;
    }


}
