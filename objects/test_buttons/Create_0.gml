/// @description Insert description here
// You can write your code in this editor


reflex_render(new ReflexContainer({
		halign: fa_center,
		valign: fa_middle,
		backgroundColor : c_blue,
		padding: { left : 20, right : 20, top : 10, bottom : 10 },
	}, [
		new ReflexButton({
			caption: "Hello World",
			margin: 5
		}),
		new ReflexButton({
			caption: "Captain America",
			margin: 5
		}),
		new ReflexButton({
			caption: "Sunshine Days",
			margin: 5
		}),
	])
);
