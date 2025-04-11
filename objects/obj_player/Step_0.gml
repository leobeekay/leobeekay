var _horizontal_input = (keyboard_check(ord("D")) || keyboard_check(vk_right)) - (keyboard_check(ord("A")) || keyboard_check(vk_left));
var _vertical_input = (keyboard_check(ord("S")) || keyboard_check(vk_down)) - (keyboard_check(ord("W")) || keyboard_check(vk_up));

// Add acceleration and deceleration
var _acceleration = 0.5;
var _deceleration = 0.05; // Reduced for more inertia when stopping
var _friction = 0.98; // Friction factor for inertia
var _max_speed = move_speed;
var _sprint_multiplier = 1.5; // Maximum speed boost when holding keys
var _sprint_buildup_rate = 0.02; // How quickly speed builds up

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
    h_sprint_factor = max(h_sprint_factor - _sprint_buildup_rate*2, 0); // Gradual reduction instead of instant reset
    
    // Apply inertia - slower deceleration for more slide effect
    h_speed *= _friction; // Apply friction
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
    v_sprint_factor = max(v_sprint_factor - _sprint_buildup_rate*2, 0); // Gradual reduction instead of instant reset
    
    // Apply inertia - slower deceleration for more slide effect
    v_speed *= _friction; // Apply friction
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
