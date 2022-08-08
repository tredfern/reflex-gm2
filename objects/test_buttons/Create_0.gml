/// @description Insert description here
// You can write your code in this editor

reflex_stylesheet({
	test_button: {
		margin : 5,
		padding : 20
	},
	
});


reflex_render(new ReflexContainer({
		halign: fa_center,
		valign: fa_middle,
		backgroundColor : c_blue,
		padding: { left : 20, right : 20, top : 10, bottom : 10 },
	}, [
		new ReflexButton({
			caption: "Hello World",
			styles: "test_button",
			onClick: function(_self) { _self.update({ caption: "Clicked!" }) }
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
	])
);
