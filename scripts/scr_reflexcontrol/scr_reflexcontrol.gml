/// ReflexControl is the base control that handles events and setting up properties for the control


function ReflexControl(_props = {}, _children = [], _default = {}) constructor {
	structShallowCopy({ x : 0, y :0, width : -1, height : -1, halign: fa_left, valign: fa_top }, self);
	structShallowCopy(_default, self);
	structShallowCopy(_props, self);
	
	children = _children;
	
	static addChild = function(_control) {
		array_push(children, _control);	
	}
	
	static update = function(_props) {
		structShallowCopy(_props, self);
		reflex_refreshLayout();
	}
}
