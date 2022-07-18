/// @description Insert description here
// You can write your code in this editor

reflex_render(
	new ReflexControlRectangle({
		halign : fa_center,
		valign : fa_middle,
		margin: 10,
		padding: 50
	}, [
		new ReflexControlRectangle({ 
			width: 25, height: 25, color : c_green }),
		new ReflexControlRectangle({ 
			 width: 25, height: 25, color : c_purple }),
		new ReflexControlRectangle({ 
			 width: 25, height: 25, color : c_blue }),
		new ReflexControlRectangle({ 
			 width: 50, height: 25, color : c_silver }),
		new ReflexControlRectangle({ 
			 width: 125, height: 25, color : c_aqua }),
		new ReflexControlRectangle({ 
			 width: 25, height: 25, color : c_navy }),
		new ReflexControlRectangle({ 
			 width: 5, height: 125, color : c_olive }),
		new ReflexControlRectangle({ 
			 width: 25, height: 25, color : c_teal })
	])
);