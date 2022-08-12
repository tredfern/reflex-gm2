///
/// Processes events in control trees
///

function reflex_processEvent(_control, _event, _raiseToParent) {
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