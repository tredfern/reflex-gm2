#macro REFLEX_LOCK_SECTION_NAME "locks"
#macro REFLEX_LOCK_ID_PROP_NAME "lockID"

enum reflex_lockStates {
	hidden = 0,
	locked = 1, 
	unlocked = 2
}

global.reflex_locks = [];

function reflex_registerLocks(_array) {
	global.reflex_locks = array_union(global.reflex_locks, _array);
}

function reflex_locksGetStatus(_lockID, _default = reflex_lockStates.hidden) {
	ini_open(reflex_statsGetSlotName());
	var _v = ini_read_real(REFLEX_LOCK_SECTION_NAME, _lockID, _default);
	ini_close();
	return _v;
}

function reflex_locksUpdateStatus(_lockID, _value) {
	ini_open(reflex_statsGetSlotName());
	ini_write_real(REFLEX_LOCK_SECTION_NAME, _lockID, _value);
	ini_close();	
}

function reflex_getLock(_lockID) {
	return array_findWhere(global.reflex_locks, function(_l, _id) { return _l.lockID == _id; }, _lockID);
}

function reflex_locksFilter(_array, _state) {
	var _out = [];
	
	for(var i = 0; i < array_length(_array); i++) {
		var _current = _array[i];
		
		//If we can't find anything to test, this is probably not lockable content
		var _currentState = reflex_lockStates.unlocked;
		var _lockID = noone;
		
		if(is_struct(_current)) {
			_lockID = variable_struct_get(_current, REFLEX_LOCK_ID_PROP_NAME);
		} else {
			_lockID = _current;
		}
		
		if(variable_not_null(_lockID)) {
			var _l = reflex_getLock(_lockID);
			if(variable_not_null(_l)) {
				_l.refresh();
				_currentState = _l.state;
			}
			
		}
		
		if(_currentState == _state) {
			array_push(_out, _current);	
		}
	}
	
	return _out;
}

function ReflexLockSystem(_lockID, _initState) constructor {
	lockID = _lockID;
	state = reflex_locksGetStatus(_lockID, _initState);
	
	static refresh = function() {
		state = reflex_locksGetStatus(lockID, state);	
	}
}