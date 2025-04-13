/// @function is_valid_position(x, y)
/// @description Checks if a position is on valid ground (not lava or walls)
/// @param {real} x The x coordinate to check
/// @param {real} y The y coordinate to check
/// @returns {bool} True if position is valid, false otherwise
function is_valid_position(_x, _y) {
    // Get the tilemap ID
    var _tilemap = get_collision_tilemap();
    if (_tilemap == -1) return false;
    
    // Check if position is NOT in a wall tile
    var _is_wall = tilemap_get_at_pixel(_tilemap, _x, _y);
    if (_is_wall) return false;
    
    // Now check if there's a floor tile - only specific tiles are valid
    var _backmap = layer_tilemap_get_id("Tiles_Back");
    if (_backmap != -1) {
        // Get the tile at this position
        var _tile_index = tilemap_get_at_pixel(_backmap, _x, _y);
        
        // If tile index is 10, it's a valid floor tile (not lava)
        // You may need to adjust this value based on your specific tileset
        if (_tile_index == 10) return true;
    }
    
    // Default to false if we can't verify it's valid ground
    return false;
}

/// @function get_collision_tilemap()
/// @description Gets the collision tilemap ID reliably
/// @returns {Id.Tilemap} Tilemap ID or -1 if not found
function get_collision_tilemap() {
    // Attempt to get the collision tilemap layer
    var _layer_id = layer_get_id("Tiles_Col");
    
    if (_layer_id != -1) {
        return layer_tilemap_get_id(_layer_id);
    }
    
    // If specific named layer not found, try all tilemap layers
    var _all_layers = layer_get_all();
    for (var i = 0; i < array_length(_all_layers); i++) {
        var _current_layer = _all_layers[i];
        var _tilemap_id = layer_tilemap_get_id(_current_layer);
        
        // Return the first valid tilemap found
        if (_tilemap_id != -1) {
            show_debug_message("Found tilemap in layer: " + layer_get_name(_current_layer));
            return _tilemap_id;
        }
    }
    
    // No tilemap found
    show_debug_message("ERROR: No tilemap found in any layer!");
    return -1;
}