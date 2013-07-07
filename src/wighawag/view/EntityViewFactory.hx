/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.view;

import wighawag.system.Entity;

interface EntityViewFactory<DrawingContextType> {
    function get(entity : Entity) : EntityView<DrawingContextType>;
}
