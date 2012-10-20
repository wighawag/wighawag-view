package com.wighawag.view;
interface Renderer<DrawingContextType> {
    function lock() : DrawingContextType;
    function unlock() : Void;
}
