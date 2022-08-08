///
/// Processes events in control trees
///


function reflex_processClick(_control) {
	if variable_struct_exists(_control, "onClick") {
		_control.onClick(_control);	
	} else {
		// pass to parent
		if (_control.parent != noone) {
			reflex_processClick(_control.parent);	
		}
	}
}