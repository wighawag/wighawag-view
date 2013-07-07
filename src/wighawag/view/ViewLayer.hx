/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.view;
interface ViewLayer<DrawingContextType> {
    public function render(context : DrawingContextType): Void;
    public function dispose() : Void;
}
