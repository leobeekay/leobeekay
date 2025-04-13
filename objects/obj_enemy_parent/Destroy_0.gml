/// @description Common enemy destruction behavior

// Drop items, play death animation, etc.
show_debug_message("Enemy destroyed: " + object_get_name(object_index));

// Optional: play death sound
// audio_play_sound(snd_enemy_death, 1, false);

// Optional: create death effect
// instance_create_layer(x, y, "Instances", obj_death_effect);

// Add score
global.score += 10;