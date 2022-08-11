
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
			display: reflex_display.inline,
			width: 400
		},
		test_menu_option: {
			halign: fa_center,
			color: c_green,
			padding: 20,
			font: fnt_defaultHeading
		},
		test_button: {
			margin : 5,
			padding : 20,
			backgroundColor: c_lime,
			font: fnt_defaultHeading,
			color: c_black,
			halign: fa_center
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
			text: "Load Game"
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