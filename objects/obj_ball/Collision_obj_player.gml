// Ball kills player on contact
with (other) {
    // Create death effect
    repeat(10) {
        instance_create_layer(x + random_range(-10, 10), y + random_range(-10, 10), "Instances", obj_ball_effect);
    }
    
    // Handle player death
    instance_destroy();
    
    // Optional: Create game over transition or restart
    with (instance_create_layer(0, 0, "Instances", obj_fade_transition)) {
        target_room = room; // Restart current room
    }
}
