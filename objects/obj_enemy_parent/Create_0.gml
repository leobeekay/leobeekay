/// @description Initialize common enemy variables

// Movement
move_speed = 1.5;
direction = random(360);
wander_direction = random(360);
wander_timer = 0;
wander_duration = room_speed * 2;

// State
state = "idle"; // idle, wander, chase
detection_radius = 200;
attack_radius = 32;
health = 3;
max_health = 3;
damage = 1;

// Get the collision tilemap
tilemap = global.collision_tilemap;

// Debug check
if (tilemap == -1) {
    show_debug_message("WARNING: Enemy created without valid collision tilemap!");
}

// Animation
image_speed = 0.2;