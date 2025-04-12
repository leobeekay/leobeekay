// Ball properties
h_speed = 0;  // Horizontal speed
v_speed = 0;  // Vertical speed
bounce_count = 0;  // Track number of bounces
max_bounces = 7;  // Maximum bounces before destruction
speed_decay = 0.99;  // Slow down slightly on each step

// Get tilemap for collision detection
tilemap = layer_tilemap_get_id("Tiles_Col");

// Visual properties
image_speed = 0.5;
image_xscale = 0.7;
image_yscale = 0.7;
