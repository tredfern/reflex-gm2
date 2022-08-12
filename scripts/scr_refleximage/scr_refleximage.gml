/// Reflex button is a standard clickable component that general has an image or text child
///
/// Buttons can have different states depending on the style of button behavior


function ReflexImage(_props = {}, _children = []) 
	: ReflexControl("image", _props, _children) constructor {
	
	static onDraw = function(_rect) {
		if (variable_struct_exists(self, "image")) {
			draw_sprite_stretched_ext(image, 0, _rect.left, _rect.top, _rect.getWidth(), _rect.getHeight(), color, alpha);	
		}
	}
}

