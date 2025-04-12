/// 
// Enemy 2 properties - faster but more erratic than enemy1
move_speed = 0.8 + random(0.4);  // Faster than enemy1
detection_radius = 180;  // Better detection than enemy1
active_radius = 300;     // Larger active area
state = "idle";          // Current behavior state
idle_timer = 0;          // Timer for idle behavior
wander_direction = random(360);  // Direction to wander
wander_timer = 0;        // Timer for changing wander direction
hp = 15;                 // Health points (less than enemy1)
change_direction_timer = 0; // Timer for erratic movement changes
dash_cooldown = 0;       // Timer for dash attack

// Get tilemap for collision detection
tilemap = layer_tilemap_get_id("Tiles_Col");