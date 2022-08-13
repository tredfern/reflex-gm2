/// @description Setup Gamepad

show_debug_message("Event = " + async_load[? "event_type"]);        // Debug code so you can see which event has been
show_debug_message("Pad = " + string(async_load[? "pad_index"]));   // triggered and the pad associated with it.



switch(async_load[? "event_type"]) {
	case "gamepad discovered":
		//gameController = async_load[? "pad_index"];       // Get the pad index value from the async_load map
	
		var _maxpads = gamepad_get_device_count();

		for (var i = 0; i < _maxpads; i++)
		{
		    if (gamepad_is_connected(i))
		    {
		        global.reflexInput.gameController = i;
				break;
		    }
		}	
	
		//TODO: Not hardcoding this stuff here...
		// Probably should have gamepad be an initialization routine for the library
		// and let the game developer figure out which ones to listen to
		gamepad_set_axis_deadzone(global.reflexInput.gameController, 0.2);       // Set the "deadzone" for the axis
		gamepad_set_button_threshold(global.reflexInput.gameController, 0.1);    // Set the "threshold" for the triggers
	break;
	
	case "gamepad lost":
		global.reflexInput.gameController = noone;
	break;
	
}