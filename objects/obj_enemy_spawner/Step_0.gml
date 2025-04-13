/// @description Handle enemy spawning

// Increment timer
spawn_timer++;

// Only spawn if timer exceeds interval and we don't have too many enemies
if (spawn_timer >= spawn_interval && instance_number(obj_enemy_parent) < max_enemies) {
    spawn_timer = 0;
    
    // Check if player exists before trying to spawn around them
    if (instance_exists(obj_player)) {
        spawn_enemy();
    } else {
        // Player doesn't exist (probably died)
        // Check if we have a player respawn system
        if (instance_exists(obj_game_controller)) {
            // Wait for player to respawn
            show_debug_message("Enemy spawner waiting for player to respawn...");
        } else {
            // Game over scenario - could stop spawning or spawn at room center
            var _center_x = room_width / 2;
            var _center_y = room_height / 2;
            spawn_enemy_at(_center_x, _center_y);
            show_debug_message("Enemy spawner using room center as fallback position");
        }
    }
}

/// Helper function to spawn enemy around player
function spawn_enemy() {
    show_debug_message("Enemy spawner attempting to create enemy...");
    
    // Select enemy type to spawn
    var _enemy_types = [obj_enemy1, obj_enemy2]; // Add more enemy types as needed
    var _enemy_type = _enemy_types[irandom(array_length(_enemy_types) - 1)];
    show_debug_message("Selected enemy type: " + object_get_name(_enemy_type));
    
    // Try to find a valid position
    var _valid_position = false;
    var _spawn_x = 0;
    var _spawn_y = 0;
    var _attempts = 0;
    var _max_attempts = 10;
    
    // Check if we have a valid tilemap for collision detection
    if (tilemap == -1) {
        tilemap = global.collision_tilemap;
        show_debug_message("Getting collision tilemap: " + string(tilemap));
    }
    
    if (backmap == -1) {
        backmap = global.back_tilemap;
        show_debug_message("Getting background tilemap: " + string(backmap));
    }
    
    while (!_valid_position && _attempts < _max_attempts) {
        // Random angle and distance from player
        var _angle = random(360);
        var _min_dist = min_spawn_distance;
        var _max_dist = spawn_radius;
        var _dist = random_range(_min_dist, _max_dist);
        
        // Calculate spawn position
        _spawn_x = obj_player.x + lengthdir_x(_dist, _angle);
        _spawn_y = obj_player.y + lengthdir_y(_dist, _angle);
        
        _valid_position = true;
        
        // Check if position is inside the room boundaries
        if (_spawn_x < 0 || _spawn_x > room_width || 
            _spawn_y < 0 || _spawn_y > room_height) {
            _valid_position = false;
        }
        
        // Check if position is inside a wall
        if (_valid_position && tilemap != -1) {
            var _is_wall = tilemap_get_at_pixel(tilemap, _spawn_x, _spawn_y);
            if (_is_wall != 0) {
                _valid_position = false;
            }
        }
        
        // Check if position is on valid ground (not lava)
        if (_valid_position && backmap != -1) {
            var _tile_index = tilemap_get_at_pixel(backmap, _spawn_x, _spawn_y);
            if (_tile_index <= 0) {
                _valid_position = false;
            }
        }
        
        _attempts++;
    }
    
    // If valid position found, spawn enemy
    if (_valid_position) {
        var _inst = instance_create_layer(_spawn_x, _spawn_y, "Instances", _enemy_type);
        with (_inst) {
            tilemap = global.collision_tilemap;
            state = "chase";
            detection_radius = 2000;
            move_speed = 1.5;
        }
        show_debug_message("Enemy spawned at " + string(_spawn_x) + ", " + string(_spawn_y));
    } else {
        show_debug_message("Failed to find valid position after " + string(_max_attempts) + " attempts");
    }
}

/// Helper function to spawn enemy at specific position
function spawn_enemy_at(_x, _y) {
    var _enemy_types = [obj_enemy1, obj_enemy2];
    var _enemy_type = _enemy_types[irandom(array_length(_enemy_types) - 1)];
    var _inst = instance_create_layer(_x, _y, "Instances", _enemy_type);
    with (_inst) {
        tilemap = global.collision_tilemap;
        state = "chase";
        detection_radius = 2000;
        move_speed = 1.5;
    }
    show_debug_message("Enemy spawned at fallback position " + string(_x) + ", " + string(_y));
}
