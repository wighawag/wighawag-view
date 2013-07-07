/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.view;

import wighawag.system.EntityComponent;

//@:autoBuild(wighawag.view.macro.EntityViewMacro.build())
interface EntityView<DrawingContextType> extends EntityComponent{
    function draw(context : DrawingContextType) : Void;
    function match() : Bool;
    function onAssociated() : Void;
}
