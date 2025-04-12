/// // Draw the player sprite
draw_self();

// Draw health bar above player
var _bar_width = 32;
var _bar_height = 4;
var _x1 = x - _bar_width/2;
var _y1 = y - sprite_height/2 - 10;
var _x2 = _x1 + _bar_width * (health / max_health);
var _y2 = _y1 + _bar_height;

// Draw health bar background (red)
draw_set_color(c_red);
draw_rectangle(_x1, _y1, _x1 + _bar_width, _y2, false);

// Draw health bar foreground (green)
draw_set_color(c_lime);
draw_rectangle(_x1, _y1, _x2, _y2, false);

// Reset draw color
draw_set_color(c_white);