
move_speed = 1;

tilemap = layer_tilemap_get_id("Tiles_Col");

// Add these variables to your existing create event
h_speed = 0;
v_speed = 0;
h_sprint_factor = 0; // Value from 0 to 1 indicating sprint buildup
v_sprint_factor = 0; // Value from 0 to 1 indicating sprint buildup