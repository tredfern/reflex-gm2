/// Reflex button is a standard clickable component that general has an image or text child
///
/// Buttons can have different states depending on the style of button behavior


enum ReflexButtonStates {
	up,
	down,
}

function ReflexButton(_props = {}, _children = []) 
	: ReflexControl("button", _props, _children) constructor {
	
	addChild(new ReflexText({ text : caption }));
	update({ backgroundImage : spriteButtonUp });
	
	static onUpdate = function() {
		setChildren([
			new ReflexText({ text : caption })
		]);
	}
}

