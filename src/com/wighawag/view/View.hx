package com.wighawag.view;

import com.wighawag.core.PositionComponent;
import com.fermmtools.utils.ObjectHash;
import com.wighawag.system.Model;
import com.wighawag.system.Updatable;
import com.wighawag.system.Entity;
import com.wighawag.system.SystemComponent;

class View<DrawingContextType> implements Updatable{

    private var renderer : Renderer<DrawingContextType>;
    private var entityViewFactory : EntityViewFactory<DrawingContextType>;
    private var model : Model;

    private var entitiesViews : ObjectHash<Entity,EntityView<DrawingContextType>>;

    public function new(model : Model, renderer : Renderer<DrawingContextType>, entityViewFactory : EntityViewFactory<DrawingContextType>) {
        entitiesViews = new ObjectHash();
        this.entityViewFactory = entityViewFactory;
        this.renderer = renderer;
        this.model = model;
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

    public function update(dt:Float):Void {

        var context = renderer.lock();

        for (entity in entitiesViews){
            entitiesViews.get(entity).draw(context);
        }

        renderer.unlock();
    }

}
