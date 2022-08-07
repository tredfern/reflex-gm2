/// @description Insert description here
// You can write your code in this editor

reflex_render(
	new ReflexRectangle({
		halign : fa_center,
		valign : fa_middle,
		margin: 10,
		padding: 50
	}, [
		new ReflexRectangle({ 
			width: 25, height: 25, color : c_green }),
		new ReflexRectangle({ 
			 width: 25, height: 25, color : c_purple }),
		new ReflexRectangle({ 
			 width: 25, height: 25, color : c_blue }),
		new ReflexRectangle({ 
			 width: 50, height: 25, color : c_silver }),
		new ReflexRectangle({ 
			 width: 125, height: 25, color : c_aqua }),
		new ReflexRectangle({ 
			 width: 25, height: 25, color : c_navy }),
		new ReflexRectangle({ 
			 width: 5, height: 125, color : c_olive }),
		new ReflexRectangle({ 
			 width: 25, height: 25, color : c_teal })
	])
);