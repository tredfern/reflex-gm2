/// Reflex Root is a layout component that is set to the boundary size of the screen
/// 
/// This allows children to easily map their properties and layout based on the screen GUI dimensions

function ReflexRoot(_props, _children) :
	ReflexControl(_props, _children) constructor {
	x = 0;
	y = 0;
	width = display_get_gui_width();
	height = display_get_gui_height();
}
