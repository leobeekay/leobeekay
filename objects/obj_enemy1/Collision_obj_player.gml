// Only damage player if not already dying
if (!other.is_dying) {
    // Use the appropriate method to decrease player health
    with(other) {
        // This executes in the context of the player object
        // where health is correctly defined
        if (variable_instance_exists(id, "max_health")) {
            health -= max_health * 0.1; // 10% of max health
        } else {
            // Fallback - use a fixed value
            health -= 10;
        }
    }
    
    // Apply knockback to player
    var _dir = point_direction(x, y, other.x, other.y);
    other.h_speed = lengthdir_x(3, _dir);
    other.v_speed = lengthdir_y(3, _dir);
    
    // Flash player to indicate damage
    other.image_alpha = 0.5;
    
    // Apply small knockback to self as well
    h_speed = lengthdir_x(-1, _dir);
    v_speed = lengthdir_y(-1, _dir);
}
