/// ReflexText renders text based on properties to the screen
///
/// Size of the ReflexText component is based on the size of the text


function ReflexDynamicText(_props = {}, _children = []) :
	ReflexControl("text", _props, _children) constructor {
	
	static getText = function() {
		if(is_string(text)) 
			return text;
		
		if(is_method(text))
			return text();
			
		return "";
	}
	
	static onLayout = function(_boxModel) {
		// Set up text size
		draw_set_font(font);
		_boxModel.setContentSize(
			string_width(getText()),
			string_height(getText())
		);
	}

	static onDraw = function(_rect) {
		draw_set_valign(fa_top);
		draw_set_halign(fa_left);
		draw_set_font(font);
		draw_text_color(_rect.left, _rect.top, getText(), color, color, color, color, alpha);
	}
}