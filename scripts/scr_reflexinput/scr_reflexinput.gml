///
/// ReflexInput handles the details of dispatching events to controls
///		depending on input events. Connect mouse, keyboard, controller
///		events to focus events for controls. 
///
/// 1. Has the mouse entered/left a control area
/// 2. Has a mouse button pressed on a control area?
/// 3. Which control has focus for keypress events?
/// 4. Should control change focus to a different control?
/// 5. Is the gamepad moving and should select another control?
/// 6. Is a gamepad button down and should trigger the focused control?
global.reflexInput = {
	focusList : [],
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
		reflex_doMouseDown(_mouseOver);
		reflex_doMouseUp(_mouseOver);
		reflex_doClick(_mouseOver);
		
		global.reflexInput.mouseOver = _mouseOver;
		
		//Change focus because of mouse button down to first match
		if (mouse_check_button_pressed(mb_any)) {
			for(var i = 0; i < array_length(_mouseOver); i++) {
				if(!variable_struct_empty(_mouseOver[i], "focusOrder")) {
					reflex_setFocus(_mouseOver[i]);	
				}
			}
		}
	}
	
	
	//Change focus to prev/next control because of keyboard/controller
	if reflex_shouldChangeFocus() {
		//Update Focus
		var _focusList = reflex_findFocusEnabled();
		var _index = array_find(_focusList, global.reflexInput.focusedControl);

		if keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_left) {
			_index--;
		} else if keyboard_check_pressed(vk_down) || keyboard_check_pressed(vk_right) {
			_index++;
		}
		_index = clamp(_index, 0, array_length(_focusList) - 1);
		
		reflex_setFocus(_focusList[_index]);
		
	}

}

function reflex_setFocus(_control) {
	if global.reflexInput.focusedControl != noone {
		reflex_processBlur(global.reflexInput.focusedControl);
	}
	
	reflex_processFocus(_control);
	global.reflexInput.focusedControl = _control;
}

function reflex_shouldChangeFocus() {
	//check keyboard
	if keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_down) ||
		keyboard_check_pressed(vk_right) || keyboard_check_pressed(vk_left) {
		return true;		
	}
	
	return false;
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

function reflex_doMouseDown(_mouseOver) {
	if (mouse_check_button_pressed(mb_any)) {
		array_onEach(_mouseOver, reflex_processMouseDown);
	}
}

function reflex_doMouseUp(_mouseOver) {
	if (mouse_check_button_released(mb_any)) {
		array_onEach(_mouseOver, reflex_processMouseUp);	
	}
}