
function array_contains(_array, _searchFor) {
	for(var i = 0; i < array_length(_array); i++) {
		if(_array[i] == _searchFor)
			return true;
	}
	
	return false;
}

function array_sum(_array, _lambda) {
	var _sum = 0;
	for(var i = 0; i < array_length(_array); i++) {
		_sum += _lambda(_array[i]);
	}
	
	return _sum;
}


//Find nearest nth objects
function instance_nearest_nth(_x, _y, _object, _count) {
	var _list = [];
	var _oldX = []
	var _oldY = []
	
	_count = min(_count, instance_number(_object));
	
	for(var i = 0; i < _count; i++) {
		_list[i] = instance_nearest(_x, _y, _object);
		_oldX[i] = _list[i].x;
		_oldY[i] = _list[i].y;
		
		//Move faraway
		_list[i].x *= 10000;
		_list[i].y *= 10000;
	}
	
	//Reset positions
	for(var i = 0; i < array_length(_list); i++) {
		_list[i].x = _oldX[i];
		_list[i].y = _oldY[i];
	}
	
	return _list;
}

function time_getTimeInFuture(_seconds) {
	return get_timer() + _seconds * 1000000;
}


function time_format_mmss(_seconds) {
	var _min = floor(_seconds / 60);
	var _sec = _seconds % 60;
	
	return string_replace(string_format(_min, 2, 0), " ", "0") + ":" + 
			string_replace(string_format(_sec, 2, 0), " ", "0");
}


function tokenString(_string, _tokens) {
	for(var i = 0; i < array_length(_tokens); i++) {
		_string = string_replace(_string, "{" + string(i) + "}", string(_tokens[i]));
	}
	
	return _string;
}

