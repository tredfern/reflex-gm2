/// ReflexText renders text based on properties to the screen
///
/// Size of the ReflexText component is based on the size of the text


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