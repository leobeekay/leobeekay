// Draw the enemy sprite
draw_self();

// Draw health bar above enemy
var _bar_width = 25;
var _bar_height = 3;
var _bar_x = x - _bar_width / 2;
var _bar_y = y - sprite_height / 2 - 8;
var _hp_percent = hp / 15; // 15 is max hp

// Draw background bar (red)
draw_set_color(c_maroon);
draw_rectangle(_bar_x, _bar_y, _bar_x + _bar_width, _bar_y + _bar_height, false);

// Draw health bar (yellow for enemy2)
draw_set_color(c_yellow);
draw_rectangle(_bar_x, _bar_y, _bar_x + (_bar_width * _hp_percent), _bar_y + _bar_height, false);

// Reset color
draw_set_color(c_white);

// Draw dash indicator if cooldown is active
if (dash_cooldown > room_speed * 2) {
    draw_set_color(c_red);
    draw_circle(x, y - sprite_height/2 - 15, 3, false);
    draw_set_color(c_white);
}
