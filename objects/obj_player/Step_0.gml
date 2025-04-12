// Handle nightmare mode effects first
if (global.difficulty == "nightmare") {
    // Handle "stuck" effect
    if (is_stuck) {
        stuck_timer--;
        if (stuck_timer <= 0) {
            is_stuck = false;
        } else {
            // Character is stuck, skip movement processing
            // Animation still happens based on last movement direction
            exit;
        }
    }
    
    // Randomly change movement properties
    nightmare_timer++;
    if (nightmare_timer >= nightmare_change_interval) {
        nightmare_timer = 0;
        nightmare_change_interval = irandom_range(30, 120);
        
        // Random effects
        var _effect = irandom(5);
        switch(_effect) {
            case 0: // Super speed
                nightmare_speed_multiplier = random_range(2, 3);
                break;
            case 1: // Super slow
                nightmare_speed_multiplier = random_range(0.3, 0.7);
                break;
            case 2: // Reverse controls
                nightmare_direction_change = 180;
                break;
            case 3: // Normal but slippery
                nightmare_speed_multiplier = 1;
                nightmare_direction_change = 0;
                break;
            case 4: // Get stuck
                is_stuck = true;
                stuck_timer = 300; // 5 seconds at 60fps
                break;
            case 5: // Normal briefly
                nightmare_speed_multiplier = 1;
                nightmare_direction_change = 0;
                break;
        }
    }
}

// Death animation handling
if (is_dying) {
    death_animation_timer++;
    // Fade out and rotate during death animation
    image_alpha = 1 - (death_animation_timer / death_animation_duration);
    image_angle += 6; // Spin as player dies
    
    // When animation completes, transition to title screen
    if (death_animation_timer >= death_animation_duration) {
        with (instance_create_layer(0, 0, "Instances", obj_fade_transition)) {
            target_room = rm_title; // Go back to title screen
        }
        instance_destroy();
        exit; // Skip the rest of the step event
    }
    exit; // Skip movement while dying
}

// Check if health is depleted
if (health <= 0 && !is_dying) {
    is_dying = true;
    death_animation_timer = 0;
    // Create death effects
    repeat(15) {
        instance_create_layer(x + random_range(-15, 15), y + random_range(-15, 15), "Instances", obj_ball_effect);
    }
    exit; // Skip the rest of the step event
}

// Regular movement code with nightmare modifications if active
var _horizontal_input = (keyboard_check(ord("D")) || keyboard_check(vk_right)) - (keyboard_check(ord("A")) || keyboard_check(vk_left));
var _vertical_input = (keyboard_check(ord("S")) || keyboard_check(vk_down)) - (keyboard_check(ord("W")) || keyboard_check(vk_up));

// Apply nightmare direction changes
if (global.difficulty == "nightmare" && nightmare_direction_change == 180) {
    _horizontal_input = -_horizontal_input;
    _vertical_input = -_vertical_input;
}

// Add acceleration and deceleration
var _acceleration = 0.5;
var _deceleration = 0.05;
var _friction = 0.98;

// Modify parameters for nightmare mode
if (global.difficulty == "nightmare") {
    _friction = 0.995; // More slippery
    move_speed = base_move_speed * nightmare_speed_multiplier;
}

var _max_speed = move_speed;
var _sprint_multiplier = 1.5;
var _sprint_buildup_rate = 0.02;

// Handle horizontal movement with acceleration/deceleration
if (_horizontal_input != 0) {
    // Increase sprint factor while holding button
    h_sprint_factor = min(h_sprint_factor + _sprint_buildup_rate, 1.0);
    
    // Accelerate with sprint factor
    h_speed += _horizontal_input * _acceleration;
    var _current_max_speed = _max_speed * (1 + h_sprint_factor * (_sprint_multiplier - 1));
    h_speed = clamp(h_speed, -_current_max_speed, _current_max_speed);
} else {
    // Reset sprint factor when not pressing key
    h_sprint_factor = max(h_sprint_factor - _sprint_buildup_rate*2, 0);
    
    // Apply inertia - slower deceleration for more slide effect
    h_speed *= _friction;
    if (abs(h_speed) < 0.1) h_speed = 0;
}

// Handle vertical movement with acceleration/deceleration
if (_vertical_input != 0) {
    // Increase sprint factor while holding button
    v_sprint_factor = min(v_sprint_factor + _sprint_buildup_rate, 1.0);
    
    // Accelerate with sprint factor
    v_speed += _vertical_input * _acceleration;
    var _current_max_speed = _max_speed * (1 + v_sprint_factor * (_sprint_multiplier - 1));
    v_speed = clamp(v_speed, -_current_max_speed, _current_max_speed);
} else {
    // Reset sprint factor when not pressing key
    v_sprint_factor = max(v_sprint_factor - _sprint_buildup_rate*2, 0);
    
    // Apply inertia - slower deceleration for more slide effect
    v_speed *= _friction;
    if (abs(v_speed) < 0.1) v_speed = 0;
}

// Apply movement
move_and_collide(h_speed, v_speed, tilemap);

// Animation logic based on movement direction
if (h_speed != 0 || v_speed != 0) {
    // Prioritize vertical animation if moving vertically
    if (abs(v_speed) > abs(h_speed)) {
        if (v_speed > 0) sprite_index = spr_player_walk_down;
        else sprite_index = spr_player_walk_up;
    } else {
        if (h_speed > 0) sprite_index = spr_player_walk_right;
        else sprite_index = spr_player_walk_left;
    }
} else {
    if (sprite_index == spr_player_walk_right) sprite_index = spr_player_idle_right
    else if (sprite_index == spr_player_walk_left) sprite_index = spr_player_idle_left
    else if (sprite_index == spr_player_walk_down) sprite_index = spr_player_idle_down
    else if (sprite_index == spr_player_walk_up) sprite_index = spr_player_idle_up
}

// Ball throwing logic
if (keyboard_check_pressed(vk_space)) {
    // Offset for ball spawn position
    var _offset_x = 0;
    var _offset_y = 0;

    // Determine offset based on player's facing direction
    if (sprite_index == spr_player_idle_right || sprite_index == spr_player_walk_right) {
        _offset_x = 16; // Spawn ball to the right of the player
    } else if (sprite_index == spr_player_idle_left || sprite_index == spr_player_walk_left) {
        _offset_x = -16; // Spawn ball to the left of the player
    } else if (sprite_index == spr_player_idle_down || sprite_index == spr_player_walk_down) {
        _offset_y = 16; // Spawn ball below the player
    } else if (sprite_index == spr_player_idle_up || sprite_index == spr_player_walk_up) {
        _offset_y = -16; // Spawn ball above the player
    }

    // Create ball at adjusted position
    var _ball = instance_create_layer(x + _offset_x, y + _offset_y, "Instances", obj_ball);

    // Set ball direction based on player's facing direction
    if (sprite_index == spr_player_idle_right || sprite_index == spr_player_walk_right) {
        _ball.h_speed = 6;
        _ball.v_speed = 0;
    } else if (sprite_index == spr_player_idle_left || sprite_index == spr_player_walk_left) {
        _ball.h_speed = -6;
        _ball.v_speed = 0;
    } else if (sprite_index == spr_player_idle_down || sprite_index == spr_player_walk_down) {
        _ball.h_speed = 0;
        _ball.v_speed = 6;
    } else if (sprite_index == spr_player_idle_up || sprite_index == spr_player_walk_up) {
        _ball.h_speed = 0;
        _ball.v_speed = -6;
    }
}

// Nightmare mode visual effect
if (global.difficulty == "nightmare" && is_stuck) {
    image_alpha = 0.5 + sin(current_time * 0.1) * 0.5; // Flashing effect when stuck
} else {
    image_alpha = 1;
}
