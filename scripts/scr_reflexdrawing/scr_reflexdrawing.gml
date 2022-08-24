///
/// ReflexDrawing routines handle the details of drawing out the control trees
///

function reflex_isDrawable(_control) {
	return variable_struct_exists(_control, "boxModel") && _control.isVisible;
}

function reflex_drawAll() {
	for(var i = 0; i < array_length(global.reflex.rootControls); i++) {
		reflex_drawControl(global.reflex.rootControls[i]);	
	}
}

function reflex_drawControl(_control) {
	if(!reflex_isDrawable(_control))
		return;
		
	reflex_drawBackground(_control);
	reflex_drawBorder(_control);
	
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

function reflex_drawBorder(_control) {
	if(!variable_struct_empty(_control, "borderColor")) {
		var _r = _control.boxModel.controlRect;
		var _border = _control.boxModel.border;
		var _color = variable_struct_get(_control, "borderColor");
		// Draw left
		draw_line_width_color(_r.left, _r.top, _r.left, _r.bottom, _border.left, _color, _color);
		
		// Draw top
		draw_line_width_color(_r.left, _r.top, _r.right, _r.top, _border.top, _color, _color);
		
		// draw right
		draw_line_width_color(_r.right, _r.top, _r.right, _r.bottom, _border.right, _color, _color);
		
		// draw bottom
		draw_line_width_color(_r.left, _r.bottom, _r.right, _r.bottom, _border.bottom, _color, _color);
		
	}
}
