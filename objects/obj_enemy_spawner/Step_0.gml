// Check if player exists
if (!instance_exists(obj_player)) exit;

// Count current enemies
var _enemy_count = instance_number(obj_enemy1) + instance_number(obj_enemy2);

// Debug message to show enemy count
// show_debug_message("Enemy count: " + string(_enemy_count) + " / " + string(max_enemies));

// Only spawn if below max enemies
if (_enemy_count < max_enemies) {
    // Decrease timer
    spawn_timer--;
    
    if (spawn_timer <= 0) {
        show_debug_message("Enemy spawner attempting to create enemy...");
        
        // Reset timer to a shorter interval for more frequent spawns
        spawn_timer = room_speed * 2; // Spawn every 2 seconds
        
        // Choose which enemy to spawn
        var _enemy_type = choose(obj_enemy1, obj_enemy2);
        show_debug_message("Selected enemy type: " + object_get_name(_enemy_type));
        
        // Make sure tilemap is initialized - important to get it every spawn attempt
        // as it may have been deactivated or changed
        tilemap = layer_tilemap_get_id("Tiles_Col");
        show_debug_message("Getting collision tilemap: " + string(tilemap));
        
        // Get background tilemap for floor validation
        var _backmap = layer_tilemap_get_id("Tiles_Back");
        show_debug_message("Getting background tilemap: " + string(_backmap));
        
        // Find valid spawn position
        var _attempts = 0;
        var _max_attempts = 50; // Increased attempts for better chance of valid position
        var _valid_position = false;
        var _spawn_x = 0;
        var _spawn_y = 0;
        
        while (!_valid_position && _attempts < _max_attempts) {
            // Get random angle and distance from player
            var _angle = random(360);
            var _dist = random_range(min_spawn_distance, spawn_radius);
            
            // Calculate spawn position
            _spawn_x = obj_player.x + lengthdir_x(_dist, _angle);
            _spawn_y = obj_player.y + lengthdir_y(_dist, _angle);
            
            // Check if position is valid
            var _is_wall = false;
            if (tilemap != -1) {
                _is_wall = tilemap_get_at_pixel(tilemap, _spawn_x, _spawn_y);
            }
            show_debug_message("Attempt " + string(_attempts) + " at " + string(_spawn_x) + "," + string(_spawn_y) + " | Is wall: " + string(_is_wall));
            
            // Check if position is valid (not in a wall)
            if (tilemap != -1 && !_is_wall) {
                // Check if it's on a valid floor tile (if backmap exists)
                if (_backmap != -1) {
                    var _tile_index = tilemap_get_at_pixel(_backmap, _spawn_x, _spawn_y);
                    show_debug_message("Floor tile index: " + string(_tile_index));
                    
                    // We need to determine which tile index represents valid floor
                    // Let's try with more floor indices to be safer
                    if (_tile_index == 10 || _tile_index == 0 || _tile_index == 13) {
                        _valid_position = true;
                        show_debug_message("Valid position found!");
                    }
                } else {
                    // If no backmap, just assume it's valid if not in a wall
                    _valid_position = true;
                    show_debug_message("No backmap, assuming valid position");
                }
            }
            
            _attempts++;
        }
        
        // If we found a valid position, spawn an enemy
        if (_valid_position) {
            show_debug_message("Spawning enemy at " + string(_spawn_x) + "," + string(_spawn_y));
            var _inst = instance_create_layer(_spawn_x, _spawn_y, "Instances", _enemy_type);
            
            // Store the collision tilemap ID so we can pass it to the created enemy
            var _collision_tilemap = tilemap;
            
            // Properly initialize the new enemy
            with (_inst) {
                // IMPORTANT: Set the tilemap DIRECTLY from the spawner's stored reference
                tilemap = _collision_tilemap;
                
                // Force the enemy to start in chase state to ensure it moves
                state = "chase";
                detection_radius = 2000; // Increased detection range temporarily
                move_speed = 0.6 + random(0.4); // Ensure it has a reasonable speed
                
                show_debug_message("Enemy created: type=" + object_get_name(object_index) + 
                                 " | tilemap=" + string(tilemap) + 
                                 " | state=" + string(state) + 
                                 " | speed=" + string(move_speed));
            }
        } else {
            show_debug_message("Failed to find valid position after " + string(_max_attempts) + " attempts");
        }
    }
}

// Update spawn interval based on difficulty
if (global.difficulty == "nightmare") {
    spawn_interval = max(room_speed, room_speed * 2 - (global.game_time / 60));
} else {
    spawn_interval = max(room_speed * 1.5, room_speed * 3 - (global.game_time / 120));
}
