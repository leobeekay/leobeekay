// Check if player exists
if (!instance_exists(obj_player)) exit;

// Count current enemies
var _enemy_count = instance_number(obj_enemy1) + instance_number(obj_enemy2);

// Only spawn if below max enemies
if (_enemy_count < max_enemies) {
    // Decrease timer
    spawn_timer--;
    
    if (spawn_timer <= 0) {
        // Reset timer
        spawn_timer = spawn_interval;
        
        // Choose which enemy to spawn
        var _enemy_type = choose(obj_enemy1, obj_enemy2);
        
        // Find valid spawn position
        var _attempts = 0;
        var _max_attempts = 20;
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
            
            // Check if position is valid (not in a wall)
            if (!tilemap_get_at_pixel(tilemap, _spawn_x, _spawn_y)) {
                _valid_position = true;
            }
            
            _attempts++;
        }
        
        // If we found a valid position, spawn an enemy
        if (_valid_position) {
            instance_create_layer(_spawn_x, _spawn_y, "Instances", _enemy_type);
        }
    }
}

// Update spawn interval based on difficulty
if (global.difficulty == "nightmare") {
    spawn_interval = max(room_speed, room_speed * 2 - (global.game_time / 60));
} else {
    spawn_interval = max(room_speed * 1.5, room_speed * 3 - (global.game_time / 120));
}
