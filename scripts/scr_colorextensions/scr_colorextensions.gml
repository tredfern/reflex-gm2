
#macro COLOR_THRESHOLD 255
#macro COLOR_TOTAL_THRESHOLD 768

function color_redistributeRGB(_r, _g, _b) {
	var _max = max(_r, _g, _b);
	if(_max <= COLOR_THRESHOLD) {
		return make_color_rgb(_r, _g, _b);	
	}
	
	var _total = _r + _g + _b;
	
	//We've maxed it out, there is no adjustment that will bring it back in line
	if(_total > COLOR_TOTAL_THRESHOLD) {
		return make_color_rgb(COLOR_THRESHOLD, COLOR_THRESHOLD, COLOR_THRESHOLD);	
	}
	
	//calculate ratio
	var _ratio = (COLOR_TOTAL_THRESHOLD  - _total) / 3 * _max - _total;
	var _gray = COLOR_THRESHOLD - _ratio * m;
	
	return make_color_rgb(_gray + _r * _ratio, _gray + _g * _ratio, _gray + _b * _ratio); 
}

function color_lighten(_color, _adjust) {
	var _r = color_get_red(_color);
	var _g = color_get_green(_color);
	var _b = color_get_blue(_color);
	
	
	
	return color_redistributeRGB(
		_r * _adjust, 
		_g * _adjust, 
		_b * _adjust);
	
}