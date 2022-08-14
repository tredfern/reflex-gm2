/// @description Initialize Reflex Library

reflex_init();

// Set up standard stylesheet
reflex_stylesheet({
	__base: { 
		x : 0, y :0, width : -1, height : -1, 
		halign: fa_left, valign: fa_top,
		display: reflex_display.block,
		alpha: 1,
		padding: 0,
		margin: 0,
		color: reflex_styleProperty.inherit,
		backgroundColor: noone,
		font: reflex_styleProperty.inherit,
		borderColor: noone,
		border: 0
	},
	button : {
		backgroundColor : c_ltgray,
		buttonState : ReflexButtonStates.up,
		spriteButtonUp : spr_buttonGrayUp,
		spriteButtonDown : spr_buttonGrayDown,
		caption : "Button",
		padding : 15,
		display: reflex_display.inline,
		hoverStyle: {
			backgroundColor : c_white
		}
	},
	container : {
		
	},
	image : {
		display : reflex_display.content,
		color: c_white
	},
	menu : {
		
	},
	menu_option : {
		focusOrder: reflex_styleProperty.auto
	},
	menu_option_text : {
		halign: fa_center	
	},
	root : {
		color: c_black,
		backgroundColor: noone,
		font: fnt_defaultText
	},
	text : { 
		text : "REFLEX UI TEXT",
		display: reflex_display.inline,
		backgroundColor: noone
	}
});




