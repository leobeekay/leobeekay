/// @description Enemy1-specific initialization

// Call the parent event first
event_inherited();

// Override default values with enemy1-specific values
move_speed = 1.5;
health = 2;
max_health = 2;
detection_radius = 250;
damage = 1;

// Enemy1-specific sprites
sprite_idle = spr_enemy1;
sprite_down = spr_enemy1;
sprite_up = spr_enemy1;
sprite_left = spr_enemy1;
sprite_right = spr_enemy1;

sprite_index = spr_enemy1;