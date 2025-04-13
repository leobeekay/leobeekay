/// @description Enemy1-specific drawing

// Override the sprite direction function
function update_sprite_direction(_direction) {
    if (_direction >= 45 && _direction < 135) {
        sprite_index = sprite_down;  // Down
    } else if (_direction >= 135 && _direction < 225) {
        sprite_index = sprite_left;  // Left
    } else if (_direction >= 225 && _direction < 315) {
        sprite_index = sprite_up;    // Up
    } else {
        sprite_index = sprite_right; // Right
    }
}

// Draw the sprite
draw_self();