/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.view;

import wighawag.system.EntityComponent;
import flash.display.BitmapData;

class GraphicsComponent implements EntityComponent{

    public function new(bitmapData : BitmapData) {
        this.bitmapData = bitmapData;
    }

    public function initialise():Void{

    }

    public var bitmapData(default, null) : BitmapData;
}
