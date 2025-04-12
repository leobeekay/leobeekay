// Only damage player if not already dying
if (!other.is_dying) {
    // Damage player - more damage during dash attack
    var _damage_percent = (state == "dash") ? 0.2 : 0.15; // 20% damage during dash, 15% normally
    other.health -= other.max_health * _damage_percent;
    
    // Apply knockback to player - stronger during dash
    var _knockback_strength = (state == "dash") ? 4.5 : 3.5;
    var _dir = point_direction(x, y, other.x, other.y);
    other.h_speed = lengthdir_x(_knockback_strength, _dir);
    other.v_speed = lengthdir_y(_knockback_strength, _dir);
    
    // Flash player to indicate damage
    other.image_alpha = 0.5;
    
    // Apply small knockback to self as well
    h_speed = lengthdir_x(-1.5, _dir);
    v_speed = lengthdir_y(-1.5, _dir);
    
    // End dash state if active
    if (state == "dash") {
        state = "chase";
        image_xscale = 1;
        image_yscale = 1;
    }
}
