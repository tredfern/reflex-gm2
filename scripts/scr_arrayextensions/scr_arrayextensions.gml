///
/// Extension helpers to array methods for more advanced manipulation
///

function array_contains(_array, _searchFor) {
	for(var i = 0; i < array_length(_array); i++) {
		if(_array[i] == _searchFor)
			return true;
	}
	
	return false;
}

function array_empty(_array) {
	if(is_array(_array))
		return array_length(_array) == 0;
	
	return true;
}

function array_sum(_array, _lambda) {
	var _sum = 0;
	for(var i = 0; i < array_length(_array); i++) {
		_sum += _lambda(_array[i]);
	}
	
	return _sum;
}

function array_pick(_array, _num) {
	if(array_length(_array) <= _num)
		return _array;
	
	
	var _out = [];
	for(var i = 0; i < _num; i++) {
		var _ind = irandom(array_length(_array) - 1);
		array_push(_out, _array[_ind]);
		array_delete(_array, _ind, 1);
	}
	
	return _out;
}

function array_find(_array, _value, _start = 0) {
	for(var i = _start; i < array_length(_array); i++) {
		if(_array[i] == _value)
			return i;
	}
	
	return -1;
}

function array_remove(_array, _value) {
	var _index = array_find(_array, _value);
	array_delete(_array, _index, 1);
}
