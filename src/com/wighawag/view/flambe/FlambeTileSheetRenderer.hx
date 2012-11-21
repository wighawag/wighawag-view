package com.wighawag.view.flambe;

import flambe.display.DrawingContext;
import com.wighawag.view.Renderer;

class FlambeTileSheetRenderer extends flambe.platform.nme.TileSheetRenderer, implements Renderer<DrawingContext>{
    public function new(graphics : nme.display.Graphics) {
        super(graphics);
    }

    public function lock() : DrawingContext{
        return super.willRender();
    }

    public function unlock() : Void{
        super.didRender();
    }
}
