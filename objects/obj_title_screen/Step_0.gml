// Debug each frame
if (current_time mod 300 == 0) {
    show_debug_message("Title screen step - menu: " + string(menu_option) + ", selected: " + string(selected));
}

// Title slide in animation
title_y = lerp(title_y, title_target_y, 0.1);
title_alpha = min(title_alpha + 0.02, 1);

// Handle menu selection
if (!selected) {
    // Move between options
    var _move = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
    if (_move != 0) {
        menu_option += _move;
        menu_option = clamp(menu_option, 0, 1);
        show_debug_message("Menu option changed to: " + string(menu_option));
    }
    
    // Select current option
    if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
        selected = true;
        show_debug_message("Option selected: " + string(menu_option));
        
        // Set difficulty based on selection
        if (menu_option == 0) {
            global.difficulty = "normal";
        } else {
            global.difficulty = "nightmare";
        }
        
        // Start transition timer
        transition_timer = 60; // Wait 1 second before transition
    }
}

// Handle transition after selecting difficulty
if (selected && transition_timer > 0) {
    transition_timer--;
    if (transition_timer <= 0) {
        show_debug_message("Transitioning to game room with difficulty: " + string(global.difficulty));
        room_goto(game_room);
    }
}