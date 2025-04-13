/// @description Enemy2-specific initialization

// Call the parent event first
event_inherited();

// Override default values with enemy2-specific values
move_speed = 1.5;
health = 2;
max_health = 2;
detection_radius = 250;
damage = 1;

// Enemy2-specific sprites
sprite_idle = spr_enemy2;
sprite_down = spr_enemy2;
sprite_up = spr_enemy2;
sprite_left = spr_enemy2;
sprite_right = spr_enemy2;

sprite_index = spr_enemy2;