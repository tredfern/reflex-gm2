/// ReflexStyles allows the creation of themed/stylesheet properties that controls
/// will use to inherit values. These values should support cascading format to allow
/// for ease of customization and total control of layout from central stylesheet properties


/// Each style is struct with properties, structs will be applied to controls on creation based
/// on style properties passed in.

enum reflex_styleProperty {
	inherit = -32544,
	auto = -32543,
	off = noone,
}

enum reflex_display {
	block,
	inline,
	content
}


function reflex_stylesheet(_stylesheet) {
	if (!variable_struct_exists(global, "reflexStyles")) {
		global.reflexStyles = {};	
	}
	var _names = variable_struct_get_names(_stylesheet);
	
	for(var i = 0; i < array_length(_names); i++) {
		if !variable_struct_exists(global.reflexStyles, _names[i]) {
			variable_struct_set(global.reflexStyles, _names[i], {});	
		}
		structShallowCopy(
			variable_struct_get(_stylesheet, _names[i]), 
			variable_struct_get(global.reflexStyles, _names[i])
		);
	}
}

function reflex_applyStyles(_control, _styleNames) {
	if (!is_string(_styleNames))
		return;
		
	var _styles = string_split(_styleNames, " ");	
	
	for(var i = 0; i < array_length(_styles); i++) {
		if(variable_struct_exists(global.reflexStyles, _styles[i])) {
			structShallowCopy(variable_struct_get(global.reflexStyles, _styles[i]), _control);
		} else {
			show_debug_message("Could not apply style: " + _styles[i])	
		}
	}
}

function reflex_inheritProperties(_control) {
	if(variable_struct_empty(_control, "parent"))
		return;
	
	var _names = variable_struct_get_names(_control);
	
	//Find inherited properties
	for(var i = 0; i < array_length(_names); i++) {
		if variable_struct_get(_control, _names[i]) == reflex_styleProperty.inherit {
			array_push(_control.inheritedProperties, _names[i]);
			
		}
	}
	
	// Update inherited property values
	for(var i = 0; i < array_length(_control.inheritedProperties); i++) {
		variable_struct_set(_control, _control.inheritedProperties[i], 
			variable_struct_get(_control.parent, _control.inheritedProperties[i]));
	}
	
	
	//Cascade any properties to children
	if(!array_empty(_control.children)) {
		for(var i = 0; i < array_length(_control.children); i++) {
			reflex_inheritProperties(_control.children[i]);
		}
	}
}

function reflex_applyTempStyle(_control, _styleName) {
	if (variable_struct_exists(_control, _styleName)) {
		var _style = variable_struct_get(_control, _styleName);
		var _cache = structShallowCopy(_style, _control);
		var _cacheName = "__" + _styleName + "Cache";
		variable_struct_set(_control, _cacheName, _cache);
		reflex_inheritProperties(_control);
	}
}

function reflex_removeTempStyle(_control, _styleName) {
	var _cacheName = "__" + _styleName + "Cache";
		
	if (variable_struct_exists(_control, _cacheName)) {
		var _style = variable_struct_get(_control, _cacheName);
		structShallowCopy(_style, _control);
		variable_struct_set(_control, _cacheName, noone);
		reflex_inheritProperties(_control);
	}
}

function reflex_applyMouseOverStyle(_control) {
	reflex_applyTempStyle(_control, "hoverStyle");
}

function reflex_removeMouseOverStyle(_control) {
	reflex_removeTempStyle(_control, "hoverStyle");
}

function reflex_applyFocusStyle(_control) {
	reflex_applyTempStyle(_control, "focusStyle");
}

function reflex_removeFocusStyle(_control) {
	reflex_removeTempStyle(_control, "focusStyle");
}