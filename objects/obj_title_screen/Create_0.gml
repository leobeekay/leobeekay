/// // Title screen variables
menu_option = 0; // 0 = Normal, 1 = Nightmare
selected = false;
transition_timer = -1;

// Initialize global difficulty - this needs to happen before any object tries to access it
if (!variable_global_exists("difficulty")) {
    global.difficulty = "normal"; // Default to normal
}

// Font setup - using try/catch to handle missing font
font_arcade = -1;
try {
    font_arcade = font_add("ArcadeClassic", 24, false, false, 32, 128);
    // if (font_arcade == -1) {
    //     show_debug_message("ERROR: Could not load ArcadeClassic font");
    //     font_arcade = font_default;
    // }
} catch(e) {
    show_debug_message("ERROR loading font: " + string(e));
    // font_arcade = global.font_default;
}

// Animated title variables
title_y = -50;
title_target_y = 100;
title_alpha = 0;

// Debug visibility test
alarm[0] = 30; // Set an alarm to show debug info after 30 steps