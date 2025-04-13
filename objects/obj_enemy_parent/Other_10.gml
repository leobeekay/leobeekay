/// @description Attack behavior (User Event 0)

// Base attack logic - child objects can override this
if (instance_exists(obj_player) && point_distance(x, y, obj_player.x, obj_player.y) <= attack_radius) {
    // Deal damage to player
    with (obj_player) {
        // Assuming player has take_damage function
        if (variable_instance_exists(id, "take_damage")) {
            take_damage(other.damage);
        }
    }
    
    // Cooldown or knockback could be added here
}