
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
}


function ReflexBoxModel(_control, _parentBox = noone) : ReflexRect(0, 0, 0, 0) constructor {
	control = _control;
	parent = _parentBox;
	
	x = 0;
	y = 0;
	contentWidth = 0;
	contentHeight = 0;
	margin = reflex_createBoundaryRect(variable_struct_get(_control, "margin"));
	padding = reflex_createBoundaryRect(variable_struct_get(_control, "padding"));
	
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
	
	static getControlRect = function() {
		var _parent = getParentContentRect();
		var _l = _parent.left + control.x + margin.left;
		var _t = _parent.top + control.y + margin.top;
		var _b = _t + contentHeight + padding.bottom + padding.top;
		var _r = _l + contentWidth + padding.right + padding.left;
		
		return new ReflexRect(_l, _t, _r, _b);
	}
	
	static getContentRect = function() {
		var _control = getControlRect();
		
		return new ReflexRect(
			_control.left + padding.left, _control.top + padding.top,
			_control.left + padding.left + contentWidth,
			_control.top + padding.top + contentHeight);
	}
	
}
