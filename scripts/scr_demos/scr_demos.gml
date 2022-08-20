
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
			padding: 0,
			width: .50,
			backgroundColor: c_dkgray
		},
		test_menu_option: {
			color: c_green,
			padding: 20,
			font: fnt_defaultHeading,
			focusOrder: reflex_styleProperty.auto,
			halign: fa_center,
			focusStyle: {
				color: c_lime,
				backgroundColor: c_ltgray	
			}
		},
		test_button: {
			margin : 5,
			padding : 20,
			backgroundColor: c_lime,
			font: fnt_defaultHeading,
			color: c_black,
			halign: fa_center,
			focusOrder: reflex_styleProperty.auto,
			border: 3,
			borderColor: noone,
			focusStyle: {
				borderColor: c_black
			}
		},
		character_window : {
			backgroundImage : spr_frame,
			width: .75,
			height: .90,
			halign: fa_center,
			valign: fa_middle,
			font: fnt_demoStats
		},
		character_option : {
			backgroundColor : c_olive,
			display: reflex_display.inline,
			width: 320,
			height: 220,
			margin: 1,
			focusOrder: reflex_styleProperty.auto,
			border: 3,
			borderColor: noone,
			hoverStyle: {
				backgroundColor : color_lighten(c_olive, 1.25)	
			},
			focusStyle: {
				borderColor	: c_black
			}
		},
		character_image : {
			width: 0.5,
			height: 0.5,
			halign: fa_center,
			valign: fa_top,
			margin: { top : 10 }
		},
		character_name : {
			halign: fa_center,
			valign: fa_bottom,
			margin: { top: 5, bottom: 5 }
		},
		character_details : {
			valign: fa_bottom,
			height: 226,
			backgroundColor: c_gray
		},
		character_stats: {
			display: reflex_display.inline,
			valign: fa_middle
		},
		character_stat: {
			margin: { top: 10, left: 10 }
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
		new ReflexProgressBar({ value: 10, maxValue: 100 }),
		new ReflexDynamicText({ value: 10, text: function() { return string(value); } })
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
		onClick: function() { showTitleScreen(); },
		onCancel: function() { showTitleScreen(); }
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
			new ReflexContainer({}, [
				new ReflexContainer({ styles: "character_list" }, [
					createCharacterOption("Pogo", spr_reflexDemoPortrait1, 100, 25, 12, "Average character with no weaknesses"),
					createCharacterOption("Migo", spr_reflexDemoPortrait2, 80, 35, 8, "Glass cannon ready to take down anyone"),
					createCharacterOption("Logo", spr_reflexDemoPortrait3, 140, 20, 15, "Defensive fortress that can soak up damage")				
				]),
				new ReflexContainer({
					controlId: "character_details", 
					styles: "character_details",
					onUpdate : function(_self) {
						if(!variable_struct_empty(_self, "characterStats")) {
							_self.setChildren([
								new ReflexContainer({styles : "character_option", valign: fa_middle, focusOrder: reflex_styleProperty.off }, [ 
									new ReflexImage({ styles: "character_image", image: _self.characterStats.image }),
									new ReflexText({ styles: "character_name", text: _self.characterStats.name }),
								
								]),
								new ReflexContainer({ styles: "character_stats" }, [
									new ReflexText({ styles: "character_stat", text: "HP: " + string(_self.characterStats.hp) }),
									new ReflexText({ styles: "character_stat", text: "ATK: " + string(_self.characterStats.atk) }),
									new ReflexText({ styles: "character_stat", text: "DEF: " + string(_self.characterStats.def) }),
									new ReflexText({ styles: "character_stat", text: _self.characterStats.desc }),
								])
							]);
						}
					}
				}, [])
			])
		])
	);
	showBackButton();
}

function createCharacterOption(_name, _image, _hp, _atk, _def, _desc) {
	return new ReflexContainer({ 
		characterStats : { name: _name, image: _image, hp : _hp, atk: _atk, def : _def, desc: _desc },
		styles: "character_option", 
		onFocus : function(_self) { updateCharacterDetails(_self.characterStats) }
	}, [
		new ReflexImage({ styles: "character_image", image: _image }),
		new ReflexText({ styles: "character_name", text : _name })
	]);
}

function updateCharacterDetails(_characterStats) {
	var _details = reflex_findById("character_details");
	_details.update({ characterStats : _characterStats });
}