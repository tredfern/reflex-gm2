
function RandomTable(_entries = []) constructor {
	entries = _entries;
	
	static add = function(_value, _weight) {
		array_push(entries, new RandomTableEntry(_value, _weight));	
	}
	
	static pick = function() {
		var _sum = array_sum(entries, function(_a) { return _a.weight; });
		var _n = random(_sum);
		
		for(var i = 0; i < array_length(entries); i++) {
			_n -= entries[i].weight;
			if (_n < 0) {
				return entries[i];	
			}
		}
	}
}

function RandomTableEntry(_value, _weight) constructor {
	value = _value;
	weight = _weight;
}