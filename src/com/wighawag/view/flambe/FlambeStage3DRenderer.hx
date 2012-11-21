package com.wighawag.view.flambe;
import flambe.display.DrawingContext;
import com.wighawag.view.Renderer;

class FlambeStage3DRenderer extends flambe.platform.flash.Stage3DRenderer, implements Renderer<DrawingContext>{
    public function new() {
        super();
    }

    public function lock() : DrawingContext{
        return super.willRender();
    }

    public function unlock() : Void{
        super.didRender();
    }
}
