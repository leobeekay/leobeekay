/// @description Common enemy AI behavior

// Check if player exists
if (!instance_exists(obj_player)) exit;

// Get tilemap for collision detection if not already assigned
if (tilemap == -1) {
    // Try to get the global reference first
    tilemap = global.collision_tilemap;
    
    // If still not found, try to get it directly
    if (tilemap == -1) {
        var _layer_id = layer_get_id("Tiles_Col");
        if (_layer_id != -1) {
            tilemap = layer_tilemap_get_id(_layer_id);
            show_debug_message("Enemy retrieved tilemap directly: " + string(tilemap));
        } else {
            show_debug_message("Enemy still can't find Tiles_Col layer");
        }
    }
}

// --- State Machine ---
var _h_speed = 0;
var _v_speed = 0;
var _dist_to_player = point_distance(x, y, obj_player.x, obj_player.y);

switch(state) {
    case "idle":
        // Do nothing, periodically transition to wander state
        wander_timer++;
        if (wander_timer >= room_speed * 2) {
            state = "wander";
            wander_timer = 0;
            wander_direction = random(360);
        }
        
        // Check if player is close enough to chase
        if (_dist_to_player < detection_radius) {
            state = "chase";
        }
        break;
        
    case "wander":
        // Move in random directions periodically
        _h_speed = lengthdir_x(move_speed * 0.5, wander_direction);
        _v_speed = lengthdir_y(move_speed * 0.5, wander_direction);
        
        wander_timer++;
        if (wander_timer >= wander_duration) {
            wander_timer = 0;
            state = "idle";
        }
        
        // Check if player is close enough to chase
        if (_dist_to_player < detection_radius) {
            state = "chase";
        }
        break;
        
    case "chase":
        // Chase the player
        var _dir = point_direction(x, y, obj_player.x, obj_player.y);
        _h_speed = lengthdir_x(move_speed, _dir);
        _v_speed = lengthdir_y(move_speed, _dir);
        
        // If player gets too far, go back to wandering
        if (_dist_to_player > detection_radius * 1.5) {
            state = "wander";
            wander_timer = 0;
            wander_direction = random(360);
        }
        
        // If close enough to attack
        if (_dist_to_player <= attack_radius) {
            // Attack player (implement in child objects if needed)
            event_user(0); // Custom event for attack behavior
        }
        break;
}

// Apply movement with collision checking
var _can_move_x = true;
var _can_move_y = true;

// Only check collision if we have a valid tilemap
if (tilemap != -1) {
    var _next_x = x + _h_speed;
    var _next_y = y + _v_speed;
    
    // Check if we can move horizontally
    if (tilemap_get_at_pixel(tilemap, _next_x, y) != 0) {
        _can_move_x = false;
    }
    
    // Check if we can move vertically
    if (tilemap_get_at_pixel(tilemap, x, _next_y) != 0) {
        _can_move_y = false;
    }
} else {
    // If no valid tilemap, log a warning but still try to move
    if (irandom(100) < 5) { // Limit the frequency of these messages
        show_debug_message("Enemy ID:" + string(id) + " moving without collision checks (invalid tilemap)");
    }
}

// Apply movement
if (_can_move_x) {
    x += _h_speed;
}
if (_can_move_y) {
    y += _v_speed;
}

// Update sprite based on movement direction
if (_h_speed != 0 || _v_speed != 0) {
    var _move_dir = point_direction(0, 0, _h_speed, _v_speed);
    
    // Set sprite based on direction - will be overridden by child objects
    // as each enemy type might have different sprites
    update_sprite_direction(_move_dir);
} else {
    image_speed = 0;
    image_index = 0;
}

// Custom sprite update function that child objects will override
function update_sprite_direction(_direction) {
    // Default implementation (child objects should override this)
    // This ensures enemy-specific sprites are used
    if (_direction >= 45 && _direction < 135) {
        // Down
        // Child objects will set their specific down sprites
    } else if (_direction >= 135 && _direction < 225) {
        // Left
        // Child objects will set their specific left sprites
    } else if (_direction >= 225 && _direction < 315) {
        // Up
        // Child objects will set their specific up sprites
    } else {
        // Right
        // Child objects will set their specific right sprites
    }
}