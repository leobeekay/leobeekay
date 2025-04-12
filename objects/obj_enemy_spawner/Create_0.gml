// Enemy spawner properties
spawn_interval = room_speed * 3; // Spawn every 3 seconds
spawn_timer = spawn_interval;
spawn_radius = 300; // Spawn radius around the player
max_enemies = 10;   // Maximum number of enemies at once
min_spawn_distance = 100; // Min distance from player

// Get tilemap for collision checking
tilemap = layer_tilemap_get_id("Tiles_Col");
