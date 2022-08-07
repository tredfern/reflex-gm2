global.reflex = {
	rootControls : [],
	hasUpdates : false,
	defaults : {
		textFont : fnt_defaultText	
	}
};

function reflex_flagUpdates() {
	global.reflex.hasUpdates = true;
}

function reflex_render(_controlTree) {
	//Traverse all controls, update children parent, find all controls that do not have a parent
	array_push(global.reflex.rootControls, new ReflexRoot({}, [_controlTree]));
	reflex_flagUpdates();
}


function reflex_processStep() {
	if (global.reflex.hasUpdates) {
		reflex_refreshLayout();
		global.reflex.hasUpdates = false;
	}
	
	reflex_processInput();	
	
	if (global.reflex.hasUpdates) {
		reflex_refreshLayout();
		global.reflex.hasUpdates = false;
	}
}


function reflex_findControlAtPoint(_x, _y) {
	//Find first control in most 
	for(var i = 0; i < array_length(global.reflex.rootControls); i++) {
		var _control = reflex_findControlAtPointRecur(_x, _y, global.reflex.rootControls[i]);
		if (_control != noone) {
			return _control;	
		}
	}
	
	return noone;
}

function reflex_findControlAtPointRecur(_x, _y, _control) {
	
	// If control has children, first search it's children for a match
	if (array_length(_control.children) > 0) {
		for(var i = 0; i < array_length(_control.children); i++) {
			var _result = reflex_findControlAtPointRecur(_x, _y, _control.children[i]);
			if (_result != noone) {
				return _result;	
			}
		}	
	} 
	
	if(_control.boxModel.contains(_x, _y)) {
		return _control;	
	}
	
	return noone;
}



