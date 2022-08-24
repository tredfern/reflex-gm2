
///
/// Original version: https://www.gmlscripts.com/script/dec_to_hex
///
function dec_to_hex(_value, _len = 1) {
	var _hex = "";
 
    if (_value < 0) {
        _len = max(_len, ceil(logn(16, 2 * abs(_value))));
    }
 
    var dig = "0123456789ABCDEF";
    while (_len-- || _value) {
        _hex = string_char_at(dig, (_value & $F) + 1) + _hex;
        _value = _value >> 4;
    }
 
    return _hex;
}