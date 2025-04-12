// Ball kills enemy on contact
with (other) {
    // Create death effect
    repeat(5) {
        instance_create_layer(x + random_range(-10, 10), y + random_range(-10, 10), "Instances", obj_ball_effect);
    }
    
    // Handle enemy death
    instance_destroy();
}
