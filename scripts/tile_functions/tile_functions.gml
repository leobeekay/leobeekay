/// @function is_valid_position(x, y)
/// @description Checks if a position is on valid ground (not lava or walls)
/// @param {real} x The x coordinate to check
/// @param {real} y The y coordinate to check
/// @returns {bool} True if position is valid, false otherwise
function is_valid_position(_x, _y) {
    // Get the tilemap ID
    var _tilemap = layer_tilemap_get_id("Tiles_Col");
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