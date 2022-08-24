
///
/// ReflexRichText
//	@description Uses scribble to draw and render strings. Supports basic scribble functionality
function ReflexRichText(_props = {}) :
	ReflexControl("text", _props) constructor {
	
	static getScribbleFormatString = function() {
		var _fontName = font_get_fontname(font);
		var _color = color_get_hexrgb(color);
		
		return string_tokenize("[{0}][{1}]{2}", [ _fontName, _color, text ]);
	}
	
	
	
	static onLayout = function(_boxModel, _maxWidth, _maxHeight) {
		var _text = getScribbleFormatString();
		_boxModel.setContentSize(
			string_width_scribble_ext(_text, _maxWidth),
			string_height_scribble_ext(_text, _maxWidth)
		);
	}

	static onDraw = function(_rect) {
		draw_text_scribble(_rect.left, _rect.top, getScribbleFormatString());
	}
}