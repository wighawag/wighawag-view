package com.wighawag.view;
import com.wighawag.system.Entity;
class SimpleEntityViewFactory implements EntityViewFactory{
    public function new() {
    }

    public function get(entity:Entity):EntityView {
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
