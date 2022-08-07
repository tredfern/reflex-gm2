
// Copies just the high-level values from one struct to another
function structShallowCopy(_from, _to) {
	var _propValues = variable_struct_get_names(_from);
	for(var i = 0; i < array_length(_propValues); i++) {
		variable_struct_set(_to, _propValues[i], variable_struct_get(_from, _propValues[i]));	
	}	
}


// Creates a new struct merging the values of the original 2 structs
function structMergeValues(_base, _override) {
	var _out = {};
	
	//Copy base values first
	structShallowCopy(_base, _out);
	//Copy override values
	structShallowCopy(_override, _out);
	
	return _out;
}
