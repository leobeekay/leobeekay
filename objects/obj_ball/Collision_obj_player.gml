// Ball reduces player health by 1/5 on contact
with (other) {
    // Create hit effect
    repeat(5) {
        instance_create_layer(x + random_range(-10, 10), y + random_range(-10, 10), "Instances", obj_ball_effect);
    }
    
    // Reduce health by 1/5 of max health
    health -= max_health / 5;
    
    // Flash the player to indicate damage
    image_alpha = 0.5;
}

// Destroy the ball after hitting player
instance_destroy();
