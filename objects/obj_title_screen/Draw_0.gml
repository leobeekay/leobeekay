// Debug room and view dimensions (only do this occasionally to avoid spamming)
if (current_time mod 1000 == 0) {
    show_debug_message("Room size: " + string(room_width) + "x" + string(room_height));
    show_debug_message("View size: " + string(view_wport[0]) + "x" + string(view_hport[0]));
    show_debug_message("Camera view: " + string(camera_get_view_width(view_camera[0])) + "x" + string(camera_get_view_height(view_camera[0])));
}

// Make sure we're drawing at the correct position based on camera/view
var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);
var _view_w = camera_get_view_width(view_camera[0]);
var _view_h = camera_get_view_height(view_camera[0]);

// Set up drawing properties
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
if (font_exists(font_arcade)) {
    draw_set_font(font_arcade);
}

// Draw title
draw_set_alpha(title_alpha);
draw_set_color(c_yellow);
draw_text_transformed(_cam_x + _view_w/2, _cam_y + title_y, "RPG ADVENTURE", 3, 3, 0);

// Draw difficulty options
draw_set_color(c_white);
draw_text(_cam_x + _view_w/2, _cam_y + _view_h/2, "SELECT DIFFICULTY");

// Normal difficulty
if (menu_option == 0) draw_set_color(c_yellow); else draw_set_color(c_gray);
draw_text_transformed(_cam_x + _view_w/2, _cam_y + _view_h/2 + 50, "NORMAL", 1.2, 1.2, 0);

// Nightmare difficulty
if (menu_option == 1) draw_set_color(c_red); else draw_set_color(c_gray);
draw_text_transformed(_cam_x + _view_w/2, _cam_y + _view_h/2 + 100, "NIGHTMARE", 1.2, 1.2, 0);

// Instructions
draw_set_color(c_white);
draw_set_alpha(title_alpha * 0.7);
draw_text(_cam_x + _view_w/2, _cam_y + _view_h - 100, "ARROW KEYS - SELECT");
draw_text(_cam_x + _view_w/2, _cam_y + _view_h - 70, "ENTER - CONFIRM");

// Debug markers so we can see if it's drawing at all
draw_set_color(c_green);
draw_circle(_cam_x + _view_w/2, _cam_y + _view_h/2, 5, false);

// Reset drawing properties
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(font_arcade); // Reset to default font