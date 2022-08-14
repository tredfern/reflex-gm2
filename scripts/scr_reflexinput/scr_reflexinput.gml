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


#macro REFLEX_CHANGE_FOCUS_DELAY 0.2

global.reflexInput = {
	focusList : [],
	focusedControl : noone,
	mouseOver : noone,
	gameController : noone,
	allowFocusChange : true
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
		
		if(is_array(_focusList) && array_length(_focusList) > 0 ) {
			var _index = array_find(_focusList, global.reflexInput.focusedControl);

			if reflex_moveToPreviousControl() {
				_index--;
			} else if reflex_moveToNextControl() {
				_index++;
			}
			_index = clamp(_index, 0, array_length(_focusList) - 1);
		
			reflex_setFocus(_focusList[_index]);
		}
		
	}
	
	//Trigger click event on control if an "Accept" button is pressed
	if !reflex_doAcceptButton() {
		reflex_doCancelButton();	
	}
	
	
}

function reflex_setFocus(_control) {
	if global.reflexInput.focusedControl != noone {
		reflex_processBlur(global.reflexInput.focusedControl);
	}
	
	reflex_processFocus(_control);
	global.reflexInput.focusedControl = _control;
}


function reflex_allowFocusChange() {
	global.reflexInput.allowFocusChange = true;	
}

function reflex_shouldChangeFocus() {
	if(!global.reflexInput.allowFocusChange)
		return false;
	
	if reflex_moveToPreviousControl() || reflex_moveToNextControl() {
		show_debug_message("reflex_createdTimesource start");
		var _t = time_source_create(
			time_source_global, 
			REFLEX_CHANGE_FOCUS_DELAY, 
			time_source_units_seconds, 
			function() { global.reflexInput.allowFocusChange = true })
		time_source_start(_t);
		global.reflexInput.allowFocusChange = false;
		show_debug_message("reflex_createdTimesource completed");
		return true;
	}
	
	return false;
}

function reflex_moveToPreviousControl() {
	if(reflex_gameControllerEnabled()) {
		var _gp = global.reflexInput.gameController;
		if (gamepad_button_check(_gp, gp_padl) || gamepad_button_check(_gp, gp_padu))
			return true;
			
		if(gamepad_axis_value(_gp, gp_axislh) < 0 || gamepad_axis_value(_gp, gp_axislv) < 0)
			return true;
	}
	
	return keyboard_check(vk_up) || keyboard_check(vk_left);
}


function reflex_moveToNextControl() {
	if(reflex_gameControllerEnabled()) {
		var _gp = global.reflexInput.gameController;
		if (gamepad_button_check(_gp, gp_padr) || gamepad_button_check(_gp, gp_padd))
			return true;
		
		if(gamepad_axis_value(_gp, gp_axislh) > 0 || gamepad_axis_value(_gp, gp_axislv) > 0)
			return true;
	}
	
	return keyboard_check(vk_down) || keyboard_check(vk_right);
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
	if(mouse_check_button_pressed(mb_left) ) {
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

function reflex_gameControllerEnabled() {
	return global.reflexInput.gameController != noone;	
}

function reflex_doAcceptButton() {
	if (keyboard_check_pressed(vk_enter)) {
		reflex_processAcceptButton(global.reflexInput.focusedControl);
		return true;
	}
	
	if (reflex_gameControllerEnabled() && gamepad_button_check_pressed(global.reflexInput.gameController, gp_face1)) {
		reflex_processAcceptButton(global.reflexInput.focusedControl);
		return true;
	}
	
	return false;
}


function reflex_doCancelButton() {
	if (keyboard_check_pressed(vk_escape)) {
		reflex_processCancelButton(global.reflexInput.focusedControl);
		return true;
	}
	
	if (reflex_gameControllerEnabled() && gamepad_button_check_pressed(global.reflexInput.gameController, gp_face2)) {
		reflex_processCancelButton(global.reflexInput.focusedControl);
		return true;
	}
	
	return false;
}