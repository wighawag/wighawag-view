package com.wighawag.view.flambe;
import com.wighawag.view.EntityView;
import com.wighawag.view.EntityViewFactory;
import com.wighawag.system.Entity;
import flambe.display.DrawingContext;
class SimpleEntityViewFactory implements EntityViewFactory<DrawingContext>{
    public function new() {
    }

    public function get(entity:Entity):EntityView<DrawingContext> {
        var view = new SimpleEntityView();
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
