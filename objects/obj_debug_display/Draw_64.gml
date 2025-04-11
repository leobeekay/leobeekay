// Display current difficulty in top-left corner
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(10, 10, "Difficulty: " + string(global.difficulty));