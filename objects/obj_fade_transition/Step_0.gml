if (state == "fade_in") {
    alpha += fade_speed;
    if (alpha >= 1) {
        room_goto(game_room); // Go to your game room
        state = "fade_out";
    }
} else if (state == "fade_out") {
    alpha -= fade_speed;
    if (alpha <= 0) {
        instance_destroy();
    }
}/// 