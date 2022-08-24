///
/// Extensions for processing strings
///

function tokenString(_string, _tokens) {
	for(var i = 0; i < array_length(_tokens); i++) {
		_string = string_replace(_string, "{" + string(i) + "}", string(_tokens[i]));
	}
	
	return _string;
}

function string_tokenize(_string, _tokens) {
	return tokenString(_string, _tokens);	
}

function string_split(_string, _delim) {
	var _nextPos = string_pos(_delim, _string);
	var _currentPos = 1;
	// NO delimiter found, return the whole string as an entry
	if _nextPos == 0 
		return [_string];
		
	var _out = [];
	
	
	while(_nextPos > 0) {
		array_push(_out, string_copy(_string, _currentPos, _nextPos - _currentPos));
		_currentPos = _nextPos + 1;
		_nextPos = string_pos_ext(_delim, _string, _currentPos);
	}
	
	if(_currentPos < string_length(_string)) {
		//Copy the last element in
		array_push(_out, string_copy(_string, _currentPos, string_length(_string) - _currentPos + 1));
	}
	
	return _out;
}

function string_notEmpty(_string) {
	return is_string(_string) && string_length(_string) > 0;	
}
