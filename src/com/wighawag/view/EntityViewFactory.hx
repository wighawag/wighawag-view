package com.wighawag.view;

import com.wighawag.system.Entity;

interface EntityViewFactory<DrawingContextType> {
    function get(entity : Entity) : EntityView<DrawingContextType>;
}
