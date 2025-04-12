// Apply speed decay
h_speed *= speed_decay;
v_speed *= speed_decay;

// Calculate next position
var _next_x = x + h_speed;
var _next_y = y + v_speed;

// Check for horizontal collision
if (tilemap_get_at_pixel(tilemap, _next_x, y)) {
    // Reverse horizontal direction and apply bounce
    h_speed = -h_speed * 1.1;
    bounce_count++;
    
    // Create bounce effect
    instance_create_layer(x, y, "Instances", obj_ball_effect);
}

// Check for vertical collision
if (tilemap_get_at_pixel(tilemap, x, _next_y)) {
    // Reverse vertical direction and apply bounce
    v_speed = -v_speed * 1.1;
    bounce_count++;
    
    // Create bounce effect
    instance_create_layer(x, y, "Instances", obj_ball_effect);
}

// Update position
x += h_speed;
y += v_speed;

// Destroy if speed too low or max bounces reached
if ((abs(h_speed) < 0.5 && abs(v_speed) < 0.5) || bounce_count >= max_bounces) {
    instance_destroy();
}

// Add rotation for visual effect
image_angle += sign(h_speed) * 5;
