///
/// A basic menu implementation
///

function ReflexMenuOption(_props) : ReflexControl("menu_option", _props) constructor {
	// Set up text size
	static onDraw = function(_rect) {
		draw_set_font(font);
		draw_text_color(_rect.left, _rect.top, text, color, color, color, color, alpha);
	}
}

function ReflexMenu(_props, _children) : ReflexControl("menu", _props, _children) constructor {
	
	
}