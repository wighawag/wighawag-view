package com.wighawag.view;

import com.wighawag.system.Updatable;

class View<DrawingContextType> implements Updatable{

    private var renderer : Renderer<DrawingContextType>;
    private var viewLayers : Array<ViewLayer<DrawingContextType>>;

    public function new(renderer : Renderer<DrawingContextType>, viewLayers : Array<ViewLayer<DrawingContextType>>) {
        this.renderer = renderer;
        this.viewLayers = viewLayers;
    }


    public function update(dt:Float):Void {

        var context = renderer.lock();

        for (layer in viewLayers){
            layer.render(context);
        }

        renderer.unlock();
    }

}
