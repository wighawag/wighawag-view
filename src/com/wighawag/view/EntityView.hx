package com.wighawag.view;

import com.wighawag.system.EntityComponent;
import flambe.display.DrawingContext;

//@:autoBuild(com.wighawag.view.macro.EntityViewMacro.build())
interface EntityView implements EntityComponent{
    function draw(context : DrawingContext) : Void;
    function match() : Bool;
    function onAssociated() : Void;
}
