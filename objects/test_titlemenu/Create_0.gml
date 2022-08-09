/// @description Insert description here
// You can write your code in this editor

reflex_stylesheet({
	test_menu: {
		halign: fa_center,
		valign: fa_middle
	},
	test_menu_option: {
		halign: fa_center,
		font: fnt_defaultText
	}
})

reflex_render(new ReflexMenu({ }, [ 
		new ReflexMenuOption({
			styles: "test_menu",
			caption: "New Game"
		}),
		new ReflexMenuOption({
			styles: "test_menu_option",
			caption: "Load Game"
		}),
		new ReflexMenuOption({
			styles: "test_menu_option",
			caption: "Options"
		}),
		new ReflexMenuOption({
			styles: "test_menu_option",
			caption: "Exit Game"
		}),
	])
);