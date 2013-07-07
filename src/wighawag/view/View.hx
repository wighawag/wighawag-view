/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.view;
import wighawag.asset.renderer.Renderer;
import wighawag.system.Updatable;

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

    public function dispose() : Void{
        for(layer in viewLayers){
            layer.dispose();
        }
    }

}
