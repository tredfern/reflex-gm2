/// Reflex button is a standard clickable component that general has an image or text child
///
/// Buttons can have different states depending on the style of button behavior


enum ReflexButtonStates {
	up,
	down,
}

function ReflexButton(_props = {}, _children = [], _default = { 
		alpha : 1,
		color : c_black,
		backgroundColor : c_white,
		buttonState : ReflexButtonStates.up,
		spriteButtonUp : spr_buttonGrayUp,
		spriteButtonDown : spr_buttonGrayDown,
		caption : "Button",
		font : fnt_defaultText,
		padding : 15 }) 
	: ReflexControl(_props, _children, _default) constructor {
	
	addChild(new ReflexText({ color : color, font : font, text : caption }));
	update({ backgroundImage : spriteButtonUp });
	
	static onUpdate = function() {
		setChildren([
			new ReflexText({ color : color, font : font, text : caption })
		]);
	}
}

