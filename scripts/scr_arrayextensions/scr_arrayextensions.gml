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


function array_each(_array, _function) {
	for(var i = 0; i < array_length(_array); i++) {
		_function(_array[i]);	
	}
}

function array_empty(_array) {
	if(is_array(_array))
		return array_length(_array) == 0;
	
	return true;
}

function array_filter(_array, _filter, _filterData = undefined) {
	var _results = [];
	
	for(var i = 0; i < array_length(_array); i++) {
		if(_filter(_array[i], _filterData)) {
			array_push(_results, _array[i]);
		}
	}
	
	return _results;
}

function array_find(_array, _value, _start = 0) {
	for(var i = _start; i < array_length(_array); i++) {
		if(_array[i] == _value)
			return i;
	}
	
	return -1;
}

function array_findWhere(_array, _filter, _filterData) {
	for(var i = 0; i < array_length(_array); i++) {
		if(_filter(_array[i], _filterData)) {
			return _array[i];	
		}
	}
	
	return noone;
}


function array_map(_array, _map) {
	var _out = [];
	
	for(var i = 0; i < array_length(_array); i++) {
		array_push(_out, _map(_array[i]));
	}
	
	return _out;
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


function array_remove(_array, _value) {
	var _index = array_find(_array, _value);
	array_delete(_array, _index, 1);
}


function array_sum(_array, _lambda) {
	var _sum = 0;
	for(var i = 0; i < array_length(_array); i++) {
		_sum += _lambda(_array[i]);
	}
	
	return _sum;
}

function array_union(_array1, _array2) {
	var _out = [];
	
	//Just copy first array in, it should be fine
	//TODO: this does present an interesting issue that if the first array is not unique?
	array_copy(_out, 0, _array1, 0, array_length(_array1));
	
	for(var i = 0; i < array_length(_array2); i++) {
		if(!array_contains(_out, _array2[i]))
			array_push(_out, _array2[i]);
	}
	
	return _out;
}


function array_without(_array, _filter) {
	var _out = [];
	
	for(var i = 0; i < array_length(_array); i++) {
		if(!array_contains(_filter, _array[i])) {
			array_push(_out, _array[i]);	
		}
	}
	
	return _out;
}

