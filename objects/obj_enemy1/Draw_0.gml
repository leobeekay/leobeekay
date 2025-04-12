// Draw the enemy sprite
draw_self();

// Draw health bar above enemy
var _bar_width = 30;
var _bar_height = 4;
var _bar_x = x - _bar_width / 2;
var _bar_y = y - sprite_height / 2 - 10;
var _hp_percent = hp / 20; // 20 is max hp

// Draw background bar (red)
draw_set_color(c_maroon);
draw_rectangle(_bar_x, _bar_y, _bar_x + _bar_width, _bar_y + _bar_height, false);

// Draw health bar (green)
draw_set_color(c_lime);
draw_rectangle(_bar_x, _bar_y, _bar_x + (_bar_width * _hp_percent), _bar_y + _bar_height, false);

// Reset color
draw_set_color(c_white);
