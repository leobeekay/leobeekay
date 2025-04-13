/// @description Initialize spawner variables

spawn_interval = room_speed * 5; // Spawn every 5 seconds
spawn_timer = 0;
spawn_radius = 300; // Spawn radius around the player
max_enemies = 10;   // Maximum number of enemies at once
min_spawn_distance = 100; // Min distance from player

// Get the tilemap for collision checks
tilemap = global.collision_tilemap;
backmap = global.back_tilemap;

show_debug_message("Enemy spawner initialized with tilemaps - Collision: " + 
                  string(tilemap) + ", Back: " + string(backmap));
