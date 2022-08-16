///
/// Processes events in control trees
///

function reflex_processEvent(_control, _event, _raiseToParent = false) {
	if variable_struct_exists(_control, _event) {
		var _handler = variable_struct_get(_control, _event);
		_handler(_control);
		return true;
	} else if (_raiseToParent) {
		if(!variable_struct_empty(_control, "parent")) {
			return reflex_processEvent(_control.parent, _event, _raiseToParent);	
		}
	}
	return false;
}

function reflex_processClick(_control) {
	return reflex_processEvent(_control, "onClick", false);
}

function reflex_processMouseEnter(_control) {
	reflex_applyMouseOverStyle(_control);
	reflex_processEvent(_control, "onMouseEnter");
}

function reflex_processMouseOver(_control) {
	reflex_processEvent(_control, "onMouseOver");
}

function reflex_processMouseExit(_control) {
	reflex_removeMouseOverStyle(_control);
	reflex_processEvent(_control, "onMouseExit");
}

function reflex_processMouseDown(_control) {
	reflex_processEvent(_control, "onMouseDown");	
}

function reflex_processMouseUp(_control) {
	reflex_processEvent(_control, "onMouseUp");	
}

function reflex_processFocus(_control) {
	show_debug_message("reflex_processFocus");
	reflex_applyFocusStyle(_control);
	reflex_processEvent(_control, "onFocus");
	show_debug_message("reflex_processFocus completed");
}

function reflex_processBlur(_control) {
	reflex_removeFocusStyle(_control);
	reflex_processEvent(_control, "onBlur");	
}

function reflex_processAcceptButton(_control) {
	reflex_processEvent(_control, "onClick");	
}

function reflex_processCancelButton(_control) {
	if !reflex_processEvent(_control, "onCancel", true) {
		var _handler = reflex_findCancelHandler();
		if _handler != noone {
			reflex_processEvent(_handler, "onCancel");	
		}
	}
}

function reflex_processUnmount(_control) {
	// If control currently has focus, remove that
	if (global.reflexInput.focusedControl == _control) {
		global.reflexInput.focusedControl = noone;	
	}
	
	reflex_processEvent(_control, "onUnmount");
}

function reflex_processStepHandler(_control) {
	reflex_processEvent(_control, "onStep");	
}