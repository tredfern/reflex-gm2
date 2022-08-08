/// ReflexStyles allows the creation of themed/stylesheet properties that controls
/// will use to inherit values. These values should support cascading format to allow
/// for ease of customization and total control of layout from central stylesheet properties


/// Each style is struct with properties, structs will be applied to controls on creation based
/// on style properties passed in.

global.reflexStyles = {
	
}

function reflex_stylesheet(_stylesheet) {
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
		structShallowCopy(variable_struct_get(global.reflexStyles, _styles[i]), _control);
	}
}