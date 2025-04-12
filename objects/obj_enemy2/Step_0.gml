/// @description More advanced enemy AI with dash attacks

// Check if player exists
if (!instance_exists(obj_player)) exit;

// Get tilemap for collision detection if not already assigned
if (tilemap == -1) {
    tilemap = layer_tilemap_get_id("Tiles_Col");
    if (tilemap == -1) {
        // Try getting it from another source
        if (instance_exists(obj_enemy_spawner) && obj_enemy_spawner.tilemap != -1) {
            tilemap = obj_enemy_spawner.tilemap;
            show_debug_message("Enemy2 got tilemap from spawner: " + string(tilemap));
        } else {
            show_debug_message("ERROR: Tilemap not found for obj_enemy2");
            exit;
        }
    }
}

// Calculate distance to player
var _dist_to_player = point_distance(x, y, obj_player.x, obj_player.y);

// Log distance and detection radius for debugging
show_debug_message("Enemy2 ID:" + string(id) + " | Distance to player: " + string(_dist_to_player) + 
                 " | Detection radius: " + string(detection_radius) + 
                 " | Player position: " + string(obj_player.x) + "," + string(obj_player.y) + 
                 " | Enemy position: " + string(x) + "," + string(y));

// Determine state based on player distance
if (_dist_to_player <= detection_radius) {
    // Chance to dash when close to player and cooldown is ready
    if (dash_cooldown <= 0 && _dist_to_player < 80 && random(1) < 0.02) {
        state = "dash";
        dash_cooldown = room_speed * 3; // 3 second cooldown
        image_xscale = 1.5;
        image_yscale = 1.5;
        show_debug_message("Enemy2 ID:" + string(id) + " entering DASH state");
    } else {
        state = "chase";
        show_debug_message("Enemy2 ID:" + string(id) + " entering CHASE state");
    }
} else {
    // Toggle between idle and wandering
    if (state == "idle") {
        idle_timer++;
        if (idle_timer >= room_speed * 1.5) { // Idle for 1.5 seconds
            state = "wander";
            idle_timer = 0;
            wander_direction = random(360);
            wander_timer = room_speed * (1 + random(1)); // Wander for 1-2 seconds
        }
    } else if (state == "wander") {
        wander_timer--;
        if (wander_timer <= 0) {
            state = "idle";
        }
        
        // Randomly change direction while wandering
        change_direction_timer++;
        if (change_direction_timer >= room_speed * 0.5) { // Every 0.5 seconds
            change_direction_timer = 0;
            if (random(1) < 0.3) { // 30% chance to change
                wander_direction = random(360);
            }
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
        
    case "dash":
        // Dash attack toward player
        var _dir = point_direction(x, y, obj_player.x, obj_player.y);
        _h_speed = lengthdir_x(move_speed * 2.5, _dir);
        _v_speed = lengthdir_y(move_speed * 2.5, _dir);
        
        // Change back to chase after a short time
        dash_cooldown--;
        if (dash_cooldown <= room_speed * 2.7) { // Dash lasts 0.3 seconds
            state = "chase";
            image_xscale = 1;
            image_yscale = 1;
        }
        break;
        
    case "wander":
        // Move in wander direction
        _h_speed = lengthdir_x(move_speed * 0.7, wander_direction);
        _v_speed = lengthdir_y(move_speed * 0.7, wander_direction);
        break;
        
    case "idle":
        // No movement
        break;
}

// Check for horizontal collision
var _next_x = x + _h_speed;
if (tilemap_get_at_pixel(tilemap, _next_x, y) == 0) {
    x = _next_x;
} else {
    // Hit wall, change direction if wandering or dashing
    if (state == "wander" || state == "dash") {
        wander_direction = random(360);
        if (state == "dash") state = "chase";
    }
}

// Check for vertical collision
var _next_y = y + _v_speed;
if (tilemap_get_at_pixel(tilemap, x, _next_y) == 0) {
    y = _next_y;
} else {
    // Hit wall, change direction if wandering or dashing
    if (state == "wander" || state == "dash") {
        wander_direction = random(360);
        if (state == "dash") state = "chase";
    }
}

// Update sprite based on movement
if (_h_speed != 0 || _v_speed != 0) {
    // Animation based on movement direction
    image_speed = 1;
    if (abs(_v_speed) > abs(_h_speed)) {
        if (_v_speed > 0) sprite_index = spr_enemy2; // Down
        else sprite_index = spr_enemy2;  // Up
    } else {
        if (_h_speed > 0) image_xscale = (state == "dash") ? 1.5 : 1;  // Right
        else image_xscale = (state == "dash") ? -1.5 : -1;  // Left (flip sprite)
    }
} else {
    image_speed = 0;
}

// Decrease dash cooldown if it's active
if (dash_cooldown > 0) {
    dash_cooldown--;
}
