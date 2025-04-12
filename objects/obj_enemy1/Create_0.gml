/// 
// Enemy 1 properties
move_speed = 0.5 + random(0.3);  // Random speed variation
detection_radius = 150;  // How far it can detect the player
active_radius = 250;     // Only move when player is within this range
state = "idle";          // Current behavior state
idle_timer = 0;          // Timer for idle behavior
wander_direction = random(360);  // Direction to wander
wander_timer = 0;        // Timer for changing wander direction
hp = 20;                 // Health points

// Assign the tilemap for collision detection
tilemap = layer_tilemap_get_id("Tiles_Col");
if (tilemap == -1) {
    show_debug_message("ERROR: Tilemap not found for obj_enemy1");
}