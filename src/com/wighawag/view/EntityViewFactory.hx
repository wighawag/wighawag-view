package com.wighawag.view;

import com.wighawag.system.Entity;

interface EntityViewFactory {
    function get(entity : Entity) : EntityView;
}
