// Debug output to check if title screen is still active
show_debug_message("Title screen is active at position: " + string(x) + ", " + string(y));
show_debug_message("Current menu option: " + string(menu_option));
show_debug_message("Selected: " + string(selected));
show_debug_message("Room: " + room_get_name(room));

// Set alarm to repeat
alarm[0] = 60;