// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ReflexProgressBar(_props, _children = []) : ReflexControl("progress_bar", _props, _children) constructor {
	
	static onDraw = function(_rect) {
		var _percentFill = value / maxValue;
	
		if(!variable_struct_empty(self, "fillImage")) {
			draw_sprite_stretched_ext(
				fillImage, 
				0,
				_rect.left,
				_rect.top,
				_rect.getWidth() * _percentFill,
				_rect.getHeight(),
				color,
				alpha);
		} else {
			//Fill with colored rectangle	
			draw_rectangle_color(
				_rect.left,
				_rect.top,
				_rect.left + _rect.getWidth() * _percentFill,
				_rect.bottom,
				color, color, color, color, false);
		}
	}
}