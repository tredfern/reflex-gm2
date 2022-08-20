#macro STATS_DB_FILE "statsdb.txt"
#macro STATS_SECTION_TOTALS "totals"
#macro STATS_SECTION_MINIMUM "minimum"
#macro STATS_SECTION_MAXIMUM "maximum"
#macro STAT_NAMES_SECTION "stat_names"

function reflex_statsNewPeriod() {
	global.reflex_stats.current = {};
}

function reflex_statsGetCurrent(_statID) {
	return variable_struct_get_default(global.reflex_stats.current, _statID, 0);
}

function reflex_statsGetTotal(_statID) {
	return variable_struct_get_default(global.reflex_stats.totals, _statID, 0);
}

function reflex_statsGetMax(_statID) {
	return variable_struct_get_default(global.reflex_stats.maximum, _statID, 0);
}

function reflex_statsGetMin(_statID) {
	return variable_struct_get_default(global.reflex_stats.minimum, _statID, 0);
}

//Increment the current counter
function reflex_statsAdd(_statID, _value = 1) {
	variable_struct_set(
		global.reflex_stats.current, _statID, variable_struct_get_default(global.reflex_stats.current, _statID, 0) + _value);
}

// Increase our total for the stat
function reflex_statsTotal(_statID) {
	variable_struct_set(global.reflex_stats.totals, _statID, 
		reflex_statsGetTotal(_statID) + reflex_statsGetCurrent(_statID));
}

function reflex_statsMax(_statID) {
	variable_struct_set(global.reflex_stats.maximum, _statID,
		max(reflex_statsGetMax(_statID), reflex_statsGetCurrent(_statID)));
}

function reflex_statsMin(_statID) {
	variable_struct_set(global.reflex_stats.minimum, _statID,
		max(reflex_statsGetMin(_statID), reflex_statsGetCurrent(_statID)));	
}

function reflex_statsSave() {
	var _slotName = global.reflex_stats.slotName;
	var _names = variable_struct_get_names(global.reflex_stats.totals);
	ini_open(_slotName);
	
	for(var i = 0; i < array_length(_names); i++) {
		ini_write_real(STATS_SECTION_TOTALS, _names[0], reflex_statsGetTotal(_names[i]));
		ini_write_real(STATS_SECTION_MAXIMUM, _names[0], reflex_statsGetMax(_names[i]));
		ini_write_real(STATS_SECTION_MINIMUM, _names[0], reflex_statsGetMin(_names[i]));
		
		ini_write_string(STAT_NAMES_SECTION, string(i), _names[0]);
	}
}

function reflex_createStatsDB(_slotName) {
	return {
		slotName: _slotName,
		totals: {},
		maximum: {},
		minimum: {},
		current: {}
	}
}

function reflex_statsLoad(_slotName = "Player1.ini") {
	var _stats = reflex_createStatsDB(_slotName);
	
	// Put player into the stats database
	ini_open(_slotName)
	var _id = 0;
	while(ini_key_exists(STAT_NAMES_SECTION, string(_id))) {
		var _name = ini_read_string(STAT_NAMES_SECTION, string(_id), "unknownStat");
		
		//Totals
		var _val = ini_read_real(STATS_SECTION_TOTALS, _name, 0);
		variable_struct_set(_stats.totals, _name, _val);
		
		//Maximum
		var _val = ini_read_real(STATS_SECTION_MAXIMUM, _name, 0);
		variable_struct_set(_stats.maximum, _name, _val);
		
		//Minimum
		var _val = ini_read_real(STATS_SECTION_MINIMUM, _name, 0);
		variable_struct_set(_stats.minimum, _name, _val);
		_id++;
	}
	ini_close();
	global.reflex_stats = _stats;
}