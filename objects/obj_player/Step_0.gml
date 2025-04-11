var _hor_input = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var _ver_input = keyboard_check(ord("S")) - keyboard_check(ord("W"));

// Add these variables to Create event if they don't exist
// move_speed = 2;        // Max speed
// acceleration = 0.2;    // How quickly speed increases
// deceleration = 0.3;    // How quickly speed decreases

// Horizontal acceleration
if (_hor_input != 0) {
    hspd = approach(hspd, _hor_input * move_speed, acceleration);
} else {
    hspd = approach(hspd, 0, deceleration);
}

// Vertical acceleration
if (_ver_input != 0) {
    vspd = approach(vspd, _ver_input * move_speed, acceleration);
} else {
    vspd = approach(vspd, 0, deceleration);
}

// Apply movement with collision
move_and_collide(hspd, vspd, tilemap);

// Animation handling
if (abs(hspd) > 0.5 || abs(vspd) > 0.5) {
    if (abs(vspd) > abs(hspd)) {
        if (vspd > 0) sprite_index = spr_player_walk_down;
        else sprite_index = spr_player_walk_up;
    } else {
        if (hspd > 0) sprite_index = spr_player_walk_right;
        else sprite_index = spr_player_walk_left;
    }
} else {
    if (sprite_index == spr_player_walk_right) sprite_index = spr_player_idle_right
    else if (sprite_index == spr_player_walk_left) sprite_index = spr_player_idle_left
    else if (sprite_index == spr_player_walk_down) sprite_index = spr_player_idle_down
    else if (sprite_index == spr_player_walk_up) sprite_index = spr_player_idle_up
}
