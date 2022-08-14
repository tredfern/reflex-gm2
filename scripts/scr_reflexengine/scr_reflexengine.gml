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

function reflex_clear() {
	global.reflex.rootControls = [];	
	reflex_flagUpdates();
}

function reflex_unrender(_controlTree) {
	if(!variable_struct_empty(_controlTree, "parent")) {
		_controlTree.parent.removeChild(_controlTree);
		
		// If your parent was a root control, than just remove that too
		if(array_contains(global.reflex.rootControls, _controlTree.parent)) {
			array_remove(global.reflex.rootControls, _controlTree.parent);	
		}
	} else {
		// Must be a root control, or not rendered at all
		array_remove(global.reflex.rootControls, _controlTree);	
	}
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


