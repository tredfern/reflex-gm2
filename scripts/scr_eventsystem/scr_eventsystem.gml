#macro EVENT_DATABASE global.reflex_stats.events

function Event(_time, _eventId) constructor {
	eventID = _eventId;
	time = _time;
}

function __reflex_eventFilterFunc(_evt, _filterData) {
	return _evt.eventID == _filterData;
}

function reflex_eventAdd(_time, _eventID) {
	array_push(EVENT_DATABASE, new Event(_time, _eventID));
}

function reflex_eventFilter(_eventID) {
	return array_filter(EVENT_DATABASE, __reflex_eventFilterFunc, _eventID);
}

function reflex_eventFind(_eventID) {
	return array_find(EVENT_DATABASE, __reflex_eventFilterFunc, _eventID);
}

function reflex_eventGetTimeBetween(_event1, _event2) {
	var _1 = reflex_eventFind(_event1);
	var _2 = reflex_eventFind(_event2);
	
	return _2.time - _1.time;
}