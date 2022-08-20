
/// @function			structShallowCopy
/// @description		Copies the properties from one struct to another.
/// @param {struct}		from	The struct to copy values from
/// @param {struct}		to		The struct to copy values to
/// @return {struct}	The list of the original values in "to" that were overwritten
function structShallowCopy(_from, _to) {
	var _propValues = variable_struct_get_names(_from);
	var _overwrittenValues = {};
	
	for(var i = 0; i < array_length(_propValues); i++) {
		var _name = _propValues[i];
		if(variable_struct_exists(_to, _name)) {
			variable_struct_set(_overwrittenValues,_name, variable_struct_get(_to, _name));
		}
		variable_struct_set(_to, _name, variable_struct_get(_from, _name));	
	}	
	
	return _overwrittenValues;
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

function struct_match(_a, _b) {
	// Count number of names
	if variable_struct_names_count(_a) != variable_struct_names_count(_b) {
		return false;
	}
	
	var _names = variable_struct_get_names(_a);
	for(var i = 0; i < array_length(_names); i ++) {
		if variable_struct_get(_a, _names[i]) != variable_struct_get(_b, _names[i]) {
			return false;
		}
	}
	
	return true;
}

function variable_struct_empty(_struct, _name) {
	if (variable_struct_exists(_struct, _name)) {
		var _v = variable_struct_get(_struct, _name);
		return _v == noone;
	}
	
	return true;
}


function variable_struct_get_default(_struct, _name, _default) {
	if(!variable_struct_exists(_struct, _name))
		return _default;
	
	return variable_struct_get(_struct, _name);
}