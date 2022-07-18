/// @description Insert description here
// You can write your code in this editor


reflex_render(new ReflexControlRectangle({
		x : 200,
		y : 200,
		backgroundColor : c_ltgray,
		padding: { left : 20, right : 20, top : 10, bottom : 10 }
	}, [ 
		new ReflexText({
			text : "HELLO WORLD!",
			padding: 10,
			backgroundColor : c_purple,
			margin : 5
		}),
		new ReflexText({
			text : "LOTS OF FUN STUFF",
			padding: 10,
			backgroundColor : c_green,
			margin: 5
		})
	])
);

