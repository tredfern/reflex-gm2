/// @description Insert description here
// You can write your code in this editor


reflex_render(new ReflexControlRectangle({
		x : 200,
		y : 200
	}, [ 
		new ReflexText({
			text : "HELLO WORLD!",
			padding: 10,
			backgroundColor : c_purple
		}),
		new ReflexText({
			text : "LOTS OF FUN STUFF",
			padding: 10,
			backgroundColor : c_green
		})
	])
);

