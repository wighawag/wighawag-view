package com.wighawag.view;
interface ViewLayer<DrawingContextType> {
    public function render(context : DrawingContextType): Void;
}