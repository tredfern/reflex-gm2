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
	for(var i = array_length(global.reflex.rootControls) - 1; i >= 0 ; i--) {
		reflex_unrender(global.reflex.rootControls[i]);
	}
	global.reflex.rootControls = [];	
	reflex_flagUpdates();
}

function reflex_unrender(_controlTree) {
	// If you have children, first unrender them
	if(!variable_struct_empty(_controlTree, "children")) {
		for(var i = array_length(_controlTree.children) - 1; i >= 0; i--) {
			reflex_unrender(_controlTree.children[i]);	
		}
	}
	
	reflex_processUnmount(_controlTree);
	if(!variable_struct_empty(_controlTree, "parent")) {
		_controlTree.parent.removeChild(_controlTree);
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
	
	reflex_keepTidy();
}

function reflex_keepTidy() {
	for(var i = array_length(global.reflex.rootControls) - 1; i >= 0; i--) {
		//If you have no children it's time to clean up
		if(array_empty(global.reflex.rootControls[i].children)) {
			array_delete(global.reflex.rootControls, i, 1);
		}
	}
}

