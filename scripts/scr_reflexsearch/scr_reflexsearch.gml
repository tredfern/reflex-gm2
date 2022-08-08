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
	findByPoint : new ReflexSearchVisitor(reflex_findControlAtPointImp)
}


function reflex_findFirstControlAtPoint(_x, _y) {
	var _search = global.reflex_searchRoutines.findByPoint.runSearch({ x : _x, y : _y });
	if (array_length(_search) > 1) {
		return _search[0];
	}
	
	return noone;
}

function reflex_findControlsAtPoint(_x, _y) {
	return global.reflex_searchRoutines.findByPoint.runSearch({ x : _x, y : _y });
}

function reflex_findControlAtPointImp(_control, _searchParams) {
	return _control.boxModel.contains(_searchParams.x, _searchParams.y);
}

