package com.wighawag.view;
import com.wighawag.asset.renderer.Renderer;
import com.wighawag.system.Updatable;

class View<DrawingContextType, TextureType> implements Updatable{

    private var renderer : Renderer<DrawingContextType, TextureType>;
    private var viewLayers : Array<ViewLayer<DrawingContextType>>;

    public function new(renderer : Renderer<DrawingContextType, TextureType>, viewLayers : Array<ViewLayer<DrawingContextType>>) {
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
