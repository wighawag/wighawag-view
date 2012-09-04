package com.wighawag.view;

import com.wighawag.core.PositionComponent;
import com.fermmtools.utils.ObjectHash;
import com.wighawag.system.Model;
import com.wighawag.system.Updatable;
import flambe.platform.Renderer;
import com.wighawag.system.Entity;
import com.wighawag.system.SystemComponent;

class View implements Updatable{

    private var renderer : Renderer;
    private var entityViewFactory : EntityViewFactory;
    private var model : Model;

    private var backgroundComponent : BackgroundComponent;

    private var entitiesViews : ObjectHash<Entity,EntityView>;

    public function new(model : Model, renderer : Renderer, entityViewFactory : EntityViewFactory) {
        entitiesViews = new ObjectHash();
        this.entityViewFactory = entityViewFactory;
        this.renderer = renderer;
        this.model = model;
        backgroundComponent = model.get(BackgroundComponent);
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

        var context = renderer.willRender();
        context.save();
        if (backgroundComponent != null){
            backgroundComponent.draw(context);
        }
        for (entity in entitiesViews){
            entitiesViews.get(entity).draw(context);
        }
        context.restore();
        renderer.didRender();

    }


}
