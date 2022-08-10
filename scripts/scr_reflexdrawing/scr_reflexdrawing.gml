///
/// ReflexDrawing routines handle the details of drawing out the control trees
///

function reflex_drawAll() {
	for(var i = 0; i < array_length(global.reflex.rootControls); i++) {
		reflex_drawControl(global.reflex.rootControls[i]);	
	}
}

function reflex_drawControl(_control) {
	reflex_drawBackground(_control);
	
	if(variable_struct_exists(_control, "onDraw")) {
		_control.onDraw(_control.boxModel.contentRect);
	}
	
	if(is_array(_control.children)) {
		for(var i = 0; i < array_length(_control.children); i++) {
			reflex_drawControl(_control.children[i]);	
		}
	}
}

function reflex_drawBackground(_control) {
	var _rect = _control.boxModel.controlRect;
	
	if (!variable_struct_empty(_control, "backgroundImage")) {
		draw_sprite_stretched_ext(
			_control.backgroundImage, 0, _rect.left, _rect.top, _rect.getWidth(), _rect.getHeight(),
			_control.backgroundColor, 1)	
	} else if (!variable_struct_empty(_control, "backgroundColor")) {
		draw_rectangle_color(_rect.left, _rect.top, _rect.right, _rect.bottom,
			_control.backgroundColor, _control.backgroundColor, _control.backgroundColor, _control.backgroundColor,
			false);
	}
	
}
