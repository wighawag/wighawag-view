package com.wighawag.view.sprite;
import com.wighawag.system.Entity;
import com.wighawag.view.EntityView;
import com.wighawag.view.EntityViewFactory;
import com.wighawag.asset.renderer.SpriteDrawingContext;
class BasicSpriteViewFactory  implements EntityViewFactory<SpriteDrawingContext>{
    public function new() {
    }

    public function get(entity:Entity):EntityView<SpriteDrawingContext> {

        var view : EntityView<SpriteDrawingContext> = new BasicSpriteView();

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
