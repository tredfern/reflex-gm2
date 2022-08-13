
///
/// Set up stylesheet for demos
///
function initializeDemo() {
	reflex_stylesheet({
		back_button: {
			halign: fa_right,
			valign: fa_top,
			margin: { right : 20 }
		},
		test_window: {
			halign: fa_center,
			valign: fa_middle,
			backgroundImage : spr_frame,
			padding: { left : 20, right : 20, top : 10, bottom : 10 },
			width: 400
		},
		test_menu: {
			halign: fa_center,
			valign: fa_middle,
			padding: 20,
			display: reflex_display.inline
		},
		test_menu_option: {
			color: c_green,
			padding: 20,
			font: fnt_defaultText
		},
		test_button: {
			margin : 5,
			padding : 20,
			backgroundColor: c_lime,
			font: fnt_defaultHeading,
			color: c_black,
			halign: fa_center
		},
		character_window : {
			backgroundImage : spr_frame,
			width: .75,
			height: .90,
			halign: fa_center,
			valign: fa_middle
		},
		character_option : {
			backgroundColor : c_olive,
			display: reflex_display.inline,
			width: 200,
			height: 200,
			margin: 1,
			hoverStyle: {
				backgroundColor : color_lighten(c_olive, 1.25)	
			}
		},
		character_image : {
			width: 0.8,
			height: 0.8,
			halign: fa_center,
			valign: fa_top,
			margin: { top : 10 }
		},
		character_name : {
			halign: fa_center,
			valign: fa_bottom,
			margin: { top: 5, bottom: 5 }
		},
		heading : {
			font : fnt_defaultHeading,
			halign: fa_center
		},
		heading_bar : {
			color: c_white,
			backgroundImage : spr_blueFrame,
			padding : 10,
			display: reflex_display.block
		}
	})
}

function showTitleScreen() {
	reflex_clear();
	reflex_render(new ReflexMenu({ 
		styles: "test_menu"
	}, [ 
		new ReflexMenuOption({
			styles: "test_menu_option",
			text: "Buttons",
			onClick: function() { showButtonDemo(); }
		}),
		new ReflexMenuOption({
			styles: "test_menu_option",
			text: "Character Select",
			onClick: function() { showCharacterSelectDemo(); },
		}),
		new ReflexMenuOption({
			styles: "test_menu_option",
			text: "Options"
		}),
		new ReflexMenuOption({
			styles: "test_menu_option",
			text: "Exit Game"
		}),
	]));
}

function showButtonDemo() {
	reflex_clear();
	reflex_render(new ReflexContainer({
		styles: "test_window",
	}, [
		new ReflexButton({
			caption: "Hello World",
			styles: "test_button",
			onClick: function(_self) { 
				_self.update({ caption: "Clicked!" }) 
			}
		}),
		new ReflexButton({
			caption: "Captain America",
			styles: "test_button",
			onClick: function(_self) { _self.update({ caption: "Clicked!" }) }
		}),
		new ReflexButton({
			caption: "Sunshine Days",
			styles: "test_button",
			onClick: function(_self) { _self.update({ caption: "Clicked!" }) }
		}),
	]));
	showBackButton();
}

function showBackButton() {
	reflex_render(new ReflexButton({
		styles : "back_button",
		caption : "Back",
		onClick: function() { showTitleScreen(); }
	}));
}

function showCharacterSelectDemo() {
	reflex_clear();
	reflex_render(
		new ReflexContainer({ styles : "character_window" }, [
			new ReflexContainer({ styles: "heading_bar" }, [
				new ReflexText({
					styles: "heading",
					text: "Select Character"
				})
			]),
			new ReflexContainer({ styles: "character_list" }, [
				new ReflexContainer({ styles: "character_option" }, [
					new ReflexImage({ styles: "character_image", image: spr_reflexDemoPortrait1 }),
					new ReflexText({ styles: "character_name", text : "Pogo" })
				]),
				new ReflexContainer({ styles: "character_option" }, [
					new ReflexImage({ styles: "character_image", image: spr_reflexDemoPortrait2 }),
					new ReflexText({ styles: "character_name", text : "Migo" })
				]),
				new ReflexContainer({ styles: "character_option" }, [
					new ReflexImage({ styles: "character_image", image: spr_reflexDemoPortrait3 }),
					new ReflexText({ styles: "character_name", text : "Logo" })
				]),
				
			]),
			new ReflexContainer({ styles: "character_details" }, [
			
			])
		])
	);
	showBackButton();
}