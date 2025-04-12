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
// Initialize global game variables
global.game_time = 0;  // Time in steps (frames)
global.score = 0;      // Player score

// Check if position is valid (not in a wall)
// if (!tilemap_get_at_pixel(tilemap, _spawn_x, _spawn_y)) {
//     _valid_position = true;
// }

// Make sure this object persists between rooms
instance_create_layer(0, 0, "Instances", obj_enemy_spawner);
// Optional debug display to show current difficulty
instance_create_layer(0, 0, layer, obj_debug_display);