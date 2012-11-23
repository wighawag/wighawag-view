package com.wighawag.view;

import com.fermmtools.utils.ObjectHash;
import com.wighawag.system.Model;
import com.wighawag.system.Entity;

class BasicViewLayer<DrawingContextType> implements ViewLayer<DrawingContextType> {

    private var entityViewFactory : EntityViewFactory<DrawingContextType>;
    private var model : Model;

    private var entitiesViews : ObjectHash<Entity,EntityView<DrawingContextType>>;

    public function new(model : Model, entityViewFactory : EntityViewFactory<DrawingContextType>) {
        entitiesViews = new ObjectHash();
        this.model = model;
        this.entityViewFactory = entityViewFactory;
        model.onEntityAdded.add(onEntityAdded);
        model.onEntityRemoved.add(onEntityRemoved);
        for(entity in model.entities){
            onEntityAdded(entity);
        }
    }

    private function onEntityAdded(entity : Entity) : Void{
        var entityView = entityViewFactory.get(entity);
        if (entityView != null){
            entitiesViews.set(entity, entityView);
        }
    }

    private function onEntityRemoved(entity : Entity) : Void{
        entitiesViews.delete(entity);
    }

    public function render(context:DrawingContextType):Void {
        for (entity in entitiesViews){
            entitiesViews.get(entity).draw(context);
        }
    }


}
