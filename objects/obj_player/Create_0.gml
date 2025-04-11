// Default movement variables
move_speed = 2; // Base movement speed
base_move_speed = move_speed;
h_speed = 0;
v_speed = 0;
h_sprint_factor = 0;
v_sprint_factor = 0;

// Tilemap for collisions
tilemap = layer_tilemap_get_id("Tiles_Col");

// Nightmare mode variables
nightmare_timer = 0;
nightmare_change_interval = irandom_range(30, 60);
nightmare_speed_multiplier = 1;
nightmare_direction_change = 0;
stuck_timer = 0;
is_stuck = false;

// Ensure difficulty exists
if (!variable_global_exists("difficulty")) {
    global.difficulty = "normal";
    show_debug_message("Player created - no difficulty set, defaulting to normal");
} else {
    show_debug_message("Player created - difficulty: " + string(global.difficulty));
}

// Apply difficulty settings
if (global.difficulty == "nightmare") {
    show_debug_message("Activating nightmare mode");
    move_speed = base_move_speed * 1.2; // Start faster
} else {
    show_debug_message("Using normal mode");
    move_speed = base_move_speed;
}