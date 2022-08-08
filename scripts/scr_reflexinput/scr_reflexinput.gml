///
/// ReflexInput handles the details of rendering
///
/// 1. Which control has focus for keypress events?
/// 2. Should control change focus to a different control?
/// 3. Has the mouse entered/left a control area
/// 4. Has a mouse button pressed on a control area?
/// 5. Is the gamepad moving and should select another control?
/// 6. Is a gamepad button down and should trigger the focused control?
global.reflexInput = {
	focusedControl : noone,
	mouseOverControl : noone
};

function reflex_processInput() {
	// Check Mouse Position
	var _mouseX = window_mouse_get_x();
	var _mouseY = window_mouse_get_y();

	var _mouseOver = reflex_findFirstControlAtPoint(_mouseX, _mouseY);
	
	if(_mouseOver != noone) {
		if(mouse_check_button_pressed(mb_left)) {
			reflex_processClick(_mouseOver);
		}
		
		global.reflexInput.mouseOverControl = _mouseOver;
	}
}