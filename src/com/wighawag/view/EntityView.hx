package com.wighawag.view;

import com.wighawag.system.EntityComponent;

//@:autoBuild(com.wighawag.view.macro.EntityViewMacro.build())
interface EntityView<DrawingContextType> implements EntityComponent{
    function draw(context : DrawingContextType) : Void;
    function match() : Bool;
    function onAssociated() : Void;
}
