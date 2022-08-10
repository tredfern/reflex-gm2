global.reflex = {
	rootControls : [],
	hasUpdates : false,
	defaults : {
		textFont : fnt_defaultText	
	}
};

enum reflex_display {
	block,
	inline
}

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


