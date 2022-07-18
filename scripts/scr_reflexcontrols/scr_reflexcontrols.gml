


function ReflexControl(_props = {}, _children = [], _default = {}) constructor {
	structShallowCopy({ x : 0, y :0, width : -1, height : -1 }, self);
	structShallowCopy(_default, self);
	structShallowCopy(_props, self);
	
	children = _children;
}

function ReflexControlRectangle(_props = {}, _children = [], 
	_default = { color : c_white, alpha : 1 }) :
	ReflexControl(_props, _children, _default) constructor {
		
	static onDraw = function(_rect) {
		draw_set_alpha(alpha);
		draw_rectangle_colour(_rect.left, _rect.top, _rect.right, _rect.bottom, color, color, color, color, false);
		draw_set_alpha(1);
	}
}

function ReflexText(_props = {}, _children = [], 
	_default = { text : "REFLEX UI TEXT", font : global.reflex.defaults.textFont, color : c_black, alpha : 1 }) :
	ReflexControl(_props, _children, _default) constructor {
	
	// Set up text size
	draw_set_font(font);
	width = string_width(text);
	height = string_height(text);

	static onDraw = function(_rect) {
		draw_set_font(font);
		draw_text_color(_rect.left, _rect.top, text, color, color, color, color, alpha);
	}
}