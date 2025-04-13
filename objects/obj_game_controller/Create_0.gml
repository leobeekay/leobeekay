// Initialize game controller
show_debug_message("Game controller created");

// Initialize global difficulty if it doesn't exist yet
if (!variable_global_exists("difficulty")) {
    global.difficulty = "normal";
    show_debug_message("Difficulty not set, initializing as: normal");
} else {
    show_debug_message("Current difficulty: " + string(global.difficulty));
}

// Initialize tilemap references for collision and floor types
var _collision_layer_id = layer_get_id("Tiles_Col");
var _back_layer_id = layer_get_id("Tiles_Back");
var _background_layer_id = layer_get_id("Background");

// Store collision tilemap
if (_collision_layer_id != -1) {
    global.collision_tilemap = layer_tilemap_get_id(_collision_layer_id);
    show_debug_message("Collision Tilemap initialized: " + string(global.collision_tilemap));
} else {
    show_debug_message("ERROR: Layer 'Tiles_Col' not found.");
    global.collision_tilemap = -1;
}

// Store background tilemap (grass)
if (_back_layer_id != -1) {
    global.back_tilemap = layer_tilemap_get_id(_back_layer_id);
    show_debug_message("Back Tilemap (grass) initialized: " + string(global.back_tilemap));
} else {
    show_debug_message("ERROR: Layer 'Tiles_Back' not found.");
    global.back_tilemap = -1;
}

// Store lava background tilemap
if (_background_layer_id != -1) {
    global.lava_tilemap = layer_tilemap_get_id(_background_layer_id);
    show_debug_message("Lava Tilemap initialized: " + string(global.lava_tilemap));
} else {
    show_debug_message("ERROR: Layer 'Background' not found.");
    global.lava_tilemap = -1;
}

// For backward compatibility - use this primarily for collision
global.tilemap = global.collision_tilemap;

// Make this object persistent so it stays between room transitions
persistent = true;
// Initialize global game variables
global.game_time = 0;  // Time in steps (frames)
global.score = 0;      // Player score

// Make sure this object persists between rooms
instance_create_layer(0, 0, "Instances", obj_enemy_spawner);
// Optional debug display to show current difficulty
instance_create_layer(0, 0, layer, obj_debug_display);