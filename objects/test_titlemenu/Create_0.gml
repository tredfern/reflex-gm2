/// @description Insert description here
// You can write your code in this editor

reflex_stylesheet({
	test_menu: {
		halign: fa_center,
		valign: fa_middle,
		padding: 20,
		display: reflex_display.inline,
		backgroundColor: c_white,
		width: 400
	},
	test_menu_option: {
		halign: fa_center,
		color: c_green,
		backgroundColor: c_white,
		padding: 20,
		font: fnt_defaultHeading
	}
})


global.uiScreens = {
	title : new ReflexMenu({ 
		styles: "test_menu"
	}, [ 
		new ReflexMenuOption({
			styles: "test_menu_option",
			text: "New Game",
			onClick: function() { global.uiScreens.title.unrender(); global.uiScreens.newGame.render(); }
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
	]),
	newGame : new ReflexMenu({
		styles: "test_menu"	
	}, [
		new ReflexMenuOption({
			styles: "test_menu_option",
			text: "New Game - Back",
			onClick: function() { global.uiScreens.newGame.unrender(); global.uiScreens.title.render(); }
		}),
	])
};

reflex_render(global.uiScreens.title);