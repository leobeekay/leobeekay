// Initialize game controller
show_debug_message("Game controller created");

// Initialize global difficulty if it doesn't exist yet
if (!variable_global_exists("difficulty")) {
    global.difficulty = "normal";
    show_debug_message("Difficulty not set, initializing as: normal");
} else {
    show_debug_message("Current difficulty: " + string(global.difficulty));
}

// Make this object persistent so it stays between room transitions
persistent = true;

// Optional debug display to show current difficulty
instance_create_layer(0, 0, layer, obj_debug_display);