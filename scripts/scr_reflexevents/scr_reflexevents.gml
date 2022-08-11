///
/// Processes events in control trees
///


function reflex_processClick(_control) {
	if variable_struct_exists(_control, "onClick") {
		_control.onClick(_control);
		return true;
	} else {
		// pass to parent
		if (!variable_struct_empty(_control, "parent")) {
			return reflex_processClick(_control.parent);	
		}
	}
	return false;
}