/// ReflexStyles allows the creation of themed/stylesheet properties that controls
/// will use to inherit values. These values should support cascading format to allow
/// for ease of customization and total control of layout from central stylesheet properties


/// Each style is struct with properties, structs will be applied to controls on creation based
/// on style properties passed in.

enum reflex_styleProperty {
	inherit = -32544
}

global.reflexStyles = {
	__base: { 
		x : 0, y :0, width : -1, height : -1, 
		halign: fa_left, valign: fa_top,
		display: reflex_display.block,
		alpha: 1,
		padding: 0,
		margin: 0,
		color: reflex_styleProperty.inherit,
		backgroundColor: reflex_styleProperty.inherit,
		font: reflex_styleProperty.inherit
	},
	button : {
		backgroundColor : c_white,
		buttonState : ReflexButtonStates.up,
		spriteButtonUp : spr_buttonGrayUp,
		spriteButtonDown : spr_buttonGrayDown,
		caption : "Button",
		padding : 15,
		display: reflex_display.inline
	},
	container : {
		
	},
	menu : {
		
	},
	menu_option : {
		halign: fa_center,
		valign: fa_middle,
	},
	root : {
		color: c_black,
		backgroundColor: noone,
		font: fnt_defaultText
	},
	text : { 
		text : "REFLEX UI TEXT",
		display: reflex_display.inline,
	}
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



function reflex_inheritProperties(_control) {
	if(variable_struct_empty(_control, "parent"))
		return;
	
	var _names = variable_struct_get_names(_control);
	
	for(var i = 0; i < array_length(_names); i++) {
		if variable_struct_get(_control, _names[i]) == reflex_styleProperty.inherit {
			//Parent should be already overridden if also set to inherit
			variable_struct_set(_control, _names[i], 
				variable_struct_get(_control.parent, _names[i]));
		}
	}
}