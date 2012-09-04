package com.wighawag.view.macro;

import haxe.macro.Type;
import haxe.macro.Expr;

typedef ComponentField = {
    var fieldName : String;
    var typeName : String;
}

// TODO REMOVE DUPLICATION (from wighawag-system ComponentInterdependencyMacro)
class EntityViewMacro {
    @:macro public static function build() : Array<Field> {

        var context = haxe.macro.Context;
        var pos = context.currentPos();

        // get the Component Class
        var localClass = context.getLocalClass().get();

        // if it is an interface, skip as we are here implementing methods
        if (localClass.isInterface){
            return null;
        }

        // Make sure the component does not extend other components
        var superClass : ClassType;
        var superClassRef = localClass.superClass;
        if (superClassRef != null){
            superClass = superClassRef.t.get();


            var errorMessage = "EntityView cannot extends another EntityView, if they need common stuff they can both extends a Class which is not itself a EntityView";

            var superFields = superClass.fields.get();
            for (superField in superFields){
                if (superField.name == "entity" ){
                    context.error(errorMessage, pos);
                    return null;
                }
            }
        }


        var constructor : Field;
        var constructorExprs : Array<Expr>;

        var requiredEntityFields : Array<ComponentField> = new Array();
        var requiredEntityTypeFields : Array<ComponentField> = new Array();

        // get the fields of the current class
        var fields = context.getBuildFields();

        // find any components dependencies (@owner) and save them
        // find the constructor and get the expression to modify it later
        for (field in fields){
            for(meta in field.meta){
                if (meta.name == "entity"){
                    switch(field.kind){
                        case FieldType.FVar( complexType, expr ):
                            switch (complexType){
                                case TPath(typePath):
                                    var fullName = "";
                                    if (typePath.pack.length >0) fullName = typePath.pack.join(".") + ".";
                                    requiredEntityFields.push({fieldName : field.name, typeName : fullName + typePath.name});
                                default : trace("not a TypePath");
                            }
                        case FieldType.FProp( get, set, complexType, expr ):
                            switch (complexType){
                                case TPath(typePath):
                                    var fullName = "";
                                    if (typePath.pack.length >0) fullName = typePath.pack.join(".") + ".";
                                    requiredEntityFields.push({fieldName : field.name, typeName : fullName + typePath.name});
                                default : trace("not a TypePath");
                            }

                        case FieldType.FFun( func ): trace("func cannot be components");
                    }
                }
                if (meta.name == "entityType"){
                    switch(field.kind){
                        case FieldType.FVar( complexType, expr ):
                            switch (complexType){
                                case TPath(typePath):
                                    var fullName = "";
                                    if (typePath.pack.length >0) fullName = typePath.pack.join(".") + ".";
                                    requiredEntityTypeFields.push({fieldName : field.name, typeName : fullName + typePath.name});
                                default : trace("not a TypePath");
                            }
                        case FieldType.FProp( get, set, complexType, expr ):
                            switch (complexType){
                                case TPath(typePath):
                                    var fullName = "";
                                    if (typePath.pack.length >0) fullName = typePath.pack.join(".") + ".";
                                    requiredEntityTypeFields.push({fieldName : field.name, typeName : fullName + typePath.name});
                                default : trace("not a TypePath");
                            }

                        case FieldType.FFun( func ): trace("func cannot be components");
                    }
                }
            }
            if (field.name == "new"){
                constructor = field;
                switch(field.kind){
                    case FieldType.FFun( func ):
                        switch (func.expr.expr){
                            case EBlock(exprs): constructorExprs = exprs;
                            default : trace( "not a block ");
                        }

                    default : trace("constructor should be a function");
                }
            }

        }

        // if there is no constructor
        if (constructor == null){
            context.error("EntityView need to have a constructor", pos);
            return null;
        }

        // add the required components to the requiredComponents instance field so that the ComponentOwner can check teh dependencies
        addRequiredComponents(constructorExprs, requiredEntityFields, requiredEntityTypeFields);


        // implement attach so that it assing the component field to the corresponding sibling components from the owner
        var associateExpr : Expr;
        // The check for missing components should not be necessary anymore as ComponentOwner does the checking
        if (requiredEntityFields.length > 0 || requiredEntityTypeFields.length > 0) {
            var exprString = "{";
            exprString += "var missingComponents : Array<Class<Dynamic>> = new Array();";


            for (requiredField in requiredEntityFields){
                exprString += "" + requiredField.fieldName + " = entity.get(" + requiredField.typeName + ");\n";
                exprString += "if ("+ requiredField.fieldName +" == null){\n";
                exprString += "missingComponents.push(" + requiredField.typeName + ");\n";
                exprString += "}\n";
            }

            for (requiredField in requiredEntityTypeFields){
                exprString += "" + requiredField.fieldName + " = entity.type.get(" + requiredField.typeName + ");\n";
                exprString += "if ("+ requiredField.fieldName +" == null){\n";
                exprString += "missingComponents.push(" + requiredField.typeName + ");\n";
                exprString += "}\n";
            }

            exprString += "if (missingComponents.length >0){\n";
            exprString += '  trace("" + Type.getClass(this) + " disabled as the owner does not have these required components " + missingComponents);\n';
            exprString += "  return false;\n";
            exprString += "}\n";

            exprString += "this.entity = entity;";
            exprString += "return match();\n";

            exprString += "}\n";

            associateExpr =  context.parse(exprString, pos);
        }
        else
        {
            associateExpr = context.parse("{this.entity = entity; return true;}", pos);
        }

        var associateFunction = {
        ret : TPath({ sub:null, name:"Bool", pack:[], params:[]}),
        params : [],
        expr : associateExpr,
        args : [{value : null, type : TPath({ sub:null, name:"Entity", pack:["com","wighawag","system"], params:[] }), opt : false, name :"entity"}] };

        fields.push({ name : "associate", doc : null, meta : null, access : [APublic], kind : FFun(associateFunction), pos : pos });


        var entityProp = FProp("default", "null", TPath({ sub:null, name:"Entity", pack:["com","wighawag","system"], params:[]}));
        fields.push({ name : "entity", doc : null, meta : null, access : [APublic], kind : entityProp, pos : pos });


        var requiredEntityComponentProp = FProp("default", "null", TPath({ sub:null, name:"Array", pack:[], params:[
            TPType(TPath({ sub:null, name:"Class", pack:[], params:[
                TPType(TPath({ sub:null, name:"Dynamic", pack:[], params:[] }))
            ]}))
        ]}));
        fields.push({ name : "requiredEntityComponents", doc : null, meta : null, access : [APublic], kind : requiredEntityComponentProp, pos : pos });

        var requiredEntityTypeComponentProp = FProp("default", "null", TPath({ sub:null, name:"Array", pack:[], params:[
        TPType(TPath({ sub:null, name:"Class", pack:[], params:[
        TPType(TPath({ sub:null, name:"Dynamic", pack:[], params:[] }))
        ]}))
        ]}));
        fields.push({ name : "requiredEntityTypeComponents", doc : null, meta : null, access : [APublic], kind : requiredEntityTypeComponentProp, pos : pos });

        return fields;
    }

    private static function addRequiredComponents(constructorExprs, requiredEntityFields : Array<ComponentField>, requiredEntityTypeFields : Array<ComponentField>):Void{

        var context = haxe.macro.Context;
        var pos = context.currentPos();

        var componentClasses = new Array<String>();

        for (requiredField in requiredEntityFields){
            componentClasses.push(requiredField.typeName);
        }

        if (componentClasses.length > 0){
            var componentClassArray = "[" + componentClasses.join(",") + "]";
            var newExpr = context.parseInlineString("requiredEntityComponents = " + componentClassArray + "", pos);
            constructorExprs.push(newExpr);
        }

        componentClasses = new Array<String>();

        for (requiredField in requiredEntityTypeFields){
            componentClasses.push(requiredField.typeName);
        }

        if (componentClasses.length > 0){
            var componentClassArray = "[" + componentClasses.join(",") + "]";
            var newExpr = context.parseInlineString("requiredEntityTypeComponents = " + componentClassArray + "", pos);
            constructorExprs.push(newExpr);
        }

    }
}
