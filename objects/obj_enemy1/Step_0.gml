/// @description Enemy AI for wandering and chasing the player
// Check if player exists
if (!instance_exists(obj_player)) exit;

// Calculate distance to player
var _dist_to_player = point_distance(x, y, obj_player.x, obj_player.y);

// Only be active if player is within active radius
if (_dist_to_player <= active_radius) {
    // Determine state based on player distance
    if (_dist_to_player <= detection_radius) {
        state = "chase";
    } else {
        // Toggle between idle and wandering
        if (state == "idle") {
            idle_timer++;
            if (idle_timer >= room_speed * 2) { // Idle for 2 seconds
                state = "wander";
                idle_timer = 0;
                wander_direction = random(360);
                wander_timer = room_speed * (1 + random(2)); // Wander for 1-3 seconds
            }
        } else if (state == "wander") {
            wander_timer--;
            if (wander_timer <= 0) {
                state = "idle";
            }
        }
    }
    
    // Handle movement based on state
    var _h_speed = 0;
    var _v_speed = 0;
    
    switch(state) {
        case "chase":
            // Move toward player
            var _dir = point_direction(x, y, obj_player.x, obj_player.y);
            _h_speed = lengthdir_x(move_speed, _dir);
            _v_speed = lengthdir_y(move_speed, _dir);
            break;
            
        case "wander":
            // Move in wander direction
            _h_speed = lengthdir_x(move_speed * 0.6, wander_direction); // Slower when wandering
            _v_speed = lengthdir_y(move_speed * 0.6, wander_direction);
            break;
            
        case "idle":
            // No movement
            break;
    }
    
    // Check for horizontal collision
    var _next_x = x + _h_speed;
    if (!tilemap_get_at_pixel(tilemap, _next_x, y)) {
        x = _next_x;
    } else {
        // Hit wall, change direction if wandering
        if (state == "wander") {
            wander_direction = random(360);
        }
    }
    
    // Check for vertical collision
    var _next_y = y + _v_speed;
    if (!tilemap_get_at_pixel(tilemap, x, _next_y)) {
        y = _next_y;
    } else {
        // Hit wall, change direction if wandering
        if (state == "wander") {
            wander_direction = random(360);
        }
    }
    
    // Update sprite based on movement
    if (_h_speed != 0 || _v_speed != 0) {
        // Animation based on movement direction
        image_speed = 1;
        if (abs(_v_speed) > abs(_h_speed)) {
            if (_v_speed > 0) sprite_index = spr_enemy1; // Down
            else sprite_index = spr_enemy1;  // Up
        } else {
            if (_h_speed > 0) image_xscale = 1;  // Right
            else image_xscale = -1;  // Left (flip sprite)
        }
    } else {
        image_speed = 0;
    }
}