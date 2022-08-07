global.reflex = {
	rootControls : [],
	hasUpdates : false,
	defaults : {
		textFont : fnt_defaultText	
	}
};


function reflex_render(_controlTree) {
	//Traverse all controls, update children parent, find all controls that do not have a parent
	array_push(global.reflex.rootControls, new ReflexRoot({}, [_controlTree]));
	global.reflex.hasUpdates = true;
}

function reflex_drawAll() {
	for(var i = 0; i < array_length(global.reflex.rootControls); i++) {
		reflex_drawControl(global.reflex.rootControls[i]);	
	}
}

function reflex_processStep() {
	if (global.reflex.hasUpdates) {
		reflex_refreshLayout();
		global.reflex.hasUpdates = false;
	}
	
	// Check Moouse Position
	var _mouseX = window_mouse_get_x();
	var _mouseY = window_mouse_get_y();
	
	
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
	
	if (variable_struct_exists(_control, "backgroundImage")) {
		draw_sprite_stretched_ext(
			_control.backgroundImage, 0, _rect.left, _rect.top, _rect.getWidth(), _rect.getHeight(),
			_control.backgroundColor, 1)	
	} else if (variable_struct_exists(_control, "backgroundColor")) {
		draw_rectangle_color(_rect.left, _rect.top, _rect.right, _rect.bottom,
			_control.backgroundColor, _control.backgroundColor, _control.backgroundColor, _control.backgroundColor,
			false);
	}
	
}

