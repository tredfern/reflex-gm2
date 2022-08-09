/// ReflexControl is the base control that handles events and setting up properties for the control


function ReflexControl(_name, _props = {}, _children = []) constructor {
	name = _name;
	reflex_applyStyles(self, "__base");
	reflex_applyStyles(self, name);
	reflex_applyStyles(self, variable_struct_get(_props, "styles"));
	structShallowCopy(_props, self);
	setChildren(_children);
	
	static addChild = function(_control) {
		array_push(children, _control);
		_control.parent = self;
		reflex_flagUpdates();
	}
	
	static setChildren = function(_array) {
		children = _array;
		setChildrenParent();
		reflex_flagUpdates();
	}
	
	static hasChildren = function() {
		return is_array(children) && array_length(children) > 0;	
	}
	
	static update = function(_props) {
		structShallowCopy(_props, self);
		reflex_flagUpdates();
		
		if(onUpdate != undefined) {
			onUpdate();	
		}
	}
	
	static setChildrenParent = function() {
		for(var i = 0; i < array_length(children); i++) {
			children[i].parent = self;	
		}
	}
	
}
