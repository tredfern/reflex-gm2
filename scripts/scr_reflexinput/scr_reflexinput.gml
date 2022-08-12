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
	mouseOver : noone
};

function reflex_processInput() {
	// Check Mouse Position
	var _mouseX = window_mouse_get_x();
	var _mouseY = window_mouse_get_y();

	var _mouseOver = reflex_findControlsAtPoint(_mouseX, _mouseY);
	
	if(!array_empty(_mouseOver)) {
		reflex_doMouseExit(_mouseOver);
		reflex_doMouseEnter(_mouseOver);
		reflex_doMouseOver(_mouseOver);
		reflex_doClick(_mouseOver);
		
		global.reflexInput.mouseOver = _mouseOver;
	}
}

function reflex_doMouseExit(_mouseOver) {
	var _exiting = array_without(global.reflexInput.mouseOver, _mouseOver);
	array_onEach(_exiting, reflex_processMouseExit);
}

function reflex_doMouseEnter(_mouseOver) {
	var _entering = array_without(_mouseOver, global.reflexInput.mouseOver);
	array_onEach(_entering, reflex_processMouseEnter);
}

function reflex_doMouseOver(_mouseOver) {
	array_onEach(_mouseOver, reflex_processMouseOver);
}


function reflex_doClick(_mouseOver) {
	if(mouse_check_button_pressed(mb_left)) {
		array_onEach(_mouseOver, reflex_processClick);
	}
}