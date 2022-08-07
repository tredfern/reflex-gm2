/// ReflexRectangle is a basic control that renders a rectangle background
///
///



function ReflexRectangle(_props = {}, _children = [], 
	_default = { color : c_white, alpha : 1 }) :
	ReflexControl(_props, _children, _default) constructor {
		
	static onDraw = function(_rect) {
		draw_set_alpha(alpha);
		draw_rectangle_colour(_rect.left, _rect.top, _rect.right, _rect.bottom, color, color, color, color, false);
		draw_set_alpha(1);
	}
}
