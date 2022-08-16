///
/// ReflexSearch provides routines that traverse the tree and find appropriate controls
///

///
/// ReflexSearchVisitor will head to all controls and return a list of matches
/// Matches are roughly in child -> parent sequence, but each node in tree is a separate sequence
///

function ReflexSearchVisitor(_searchRoutine) constructor {
	searchRoutine = _searchRoutine;
	searchParams = { };
	results = [];
	
	static runSearch = function(_searchParams) {
		searchParams = _searchParams;
		results = [];
		// Execute find routine across rootControls array
		for(var i = 0; i < array_length(global.reflex.rootControls); i++) {
			find(global.reflex.rootControls[i]);
		}
		
		return results;
	}
	
	static runFirstSearch = function(_searchParams) {
		runSearch(_searchParams);
		if array_length(results) >= 1
			return results[0];
		
		return noone;
	}
	
	static find = function(_control) {
		if(_control.hasChildren()) {
			for(var i = 0; i < array_length(_control.children); i++) {
				find(_control.children[i]);	
			}
		}
		
		if(searchRoutine(_control, searchParams)) {
			array_push(results, _control);
		}
	}
	
	
}

global.reflex_searchRoutines = {
	findByPoint : new ReflexSearchVisitor(reflex_findControlAtPointImp),
	findById : new ReflexSearchVisitor(reflex_findByIdImp),
	findByFocusEnabled: new ReflexSearchVisitor(reflex_findFocusEnabledImp),
	findCancelHandler: new ReflexSearchVisitor(reflex_findHandlerImp)
}

function reflex_findControlsAtPoint(_x, _y) {
	return global.reflex_searchRoutines.findByPoint.runSearch({ x : _x, y : _y });
}

function reflex_findControlAtPointImp(_control, _searchParams) {
	return _control.boxModel.contains(_searchParams.x, _searchParams.y);
}

function reflex_findById(_id) {
	return global.reflex_searchRoutines.findById.runFirstSearch({ controlId : _id });
}

function reflex_findByIdImp(_control, _searchParams) {
	if(variable_struct_empty(_control, "controlId"))
		return false;
		
	return _control.controlId == _searchParams.controlId;
}

function reflex_findFocusEnabled() {
	return global.reflex_searchRoutines.findByFocusEnabled.runSearch({});	
}

function reflex_findFocusEnabledImp(_control, _searchParams) {
	return !variable_struct_empty(_control, "focusOrder");
}

function reflex_findCancelHandler() {
	return global.reflex_searchRoutines.findCancelHandler.runFirstSearch({ handler : "onCancel" });	
}

function reflex_findHandlerImp(_control, _searchParams) {
	return !variable_struct_empty(_control, _searchParams.handler);
}