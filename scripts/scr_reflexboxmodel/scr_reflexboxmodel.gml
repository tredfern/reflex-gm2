
function reflex_createBoundaryRect(_boundaryValue) {
	if(_boundaryValue == noone or _boundaryValue == undefined) 
		return new ReflexRect(0, 0, 0, 0);
		
	if(is_numeric(_boundaryValue))
		return new ReflexRect(_boundaryValue, _boundaryValue, _boundaryValue, _boundaryValue);
		
	if(is_struct(_boundaryValue))
		return structMergeValues({ left : 0, right : 0, top : 0, bottom : 0}, _boundaryValue);
}

function ReflexRect(_left, _top, _right, _bottom) constructor {
	left = _left;
	top = _top;
	right = _right;
	bottom = _bottom;
	
	static getWidth = function() { return right - left; };
	static getHeight = function() { return bottom - top; };
	
	static contains = function(_x, _y) {
		return left < _x && right > _x && _y > top && _y < bottom;	
	}
}


function ReflexBoxModel(_control, _parentBox = noone) constructor {
	control = _control;
	parent = _parentBox;
	
	x = 0;
	y = 0;
	contentWidth = 0;
	contentHeight = 0;
	margin = reflex_createBoundaryRect(variable_struct_get(_control, "margin"));
	padding = reflex_createBoundaryRect(variable_struct_get(_control, "padding"));
	border = reflex_createBoundaryRect(variable_struct_get(_control, "border"));
	
	static setContentSize = function(_w, _h) {
		contentWidth = _w;
		contentHeight = _h;
	}
	
	static getParentContentRect = function() {
		if(parent == noone) {
			return  new ReflexRect(0, 0, display_get_gui_width(), display_get_gui_height());
		}
		
		return parent.getContentRect();
	}
	
	static calculateAreas = function() {
		controlRect = getControlRect();
		contentRect = getContentRect();
	}
	
	static getControlRect = function() {
		var _parent = getParentContentRect();
		var _l = _parent.left + control.x + margin.left;
		var _t = _parent.top + control.y + margin.top;
		var _b = _t + contentHeight + padding.bottom + padding.top + border.top + border.bottom;
		var _r = _l + contentWidth + padding.right + padding.left + border.left + border.right;
		
		return new ReflexRect(_l, _t, _r, _b);
	}
	
	static getContentRect = function() {
		var _control = getControlRect();
		
		return new ReflexRect(
			_control.left + padding.left + border.left, _control.top + padding.top + border.top,
			_control.left + padding.left + border.left + contentWidth,
			_control.top + padding.top + border.top + contentHeight);
	}
	
	static getFullArea = function() {
		var _parent = getParentContentRect();
		var _l = _parent.left + control.x;
		var _t = _parent.top + control.y;
		var _b = _t + contentHeight + padding.bottom + padding.top + margin.top + margin.bottom + border.top + border.bottom;
		var _r = _l + contentWidth + padding.right + padding.left + margin.left + margin.right + border.left + border.right;
		
		return new ReflexRect(_l, _t, _r, _b);
	}
	
	static contains = function(_x, _y) {
		return controlRect.contains(_x, _y);
	}
}
