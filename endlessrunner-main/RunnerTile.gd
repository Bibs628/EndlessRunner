extends Node3D

@export var coin: PackedScene
@export var obstacle: PackedScene
@export var coin_spawn := tilemap_height*5
var coordinates := []
var replace_tiles := [true, false]
var tilemap_width := 70  # Set the width of the tilemap
var tilemap_height := 5  # Set the height of the tilemap
var tile_spacing := 1  # Variable to control the spacing between tiles

# Feste Variablen für die Positionen der Münzen und Hindernisse
var coin_y_position := 1.5
var obstacle_y_position := 1

func _ready() -> void:
	create_tilemap()
	create_coins()
	create_obstacles()
	 
	if replace_tiles.pick_random():
		var replace = $GridMap.get_used_cells_by_item(1)
		for i in replace.size():
			$GridMap.set_cell_item(replace[i], 5, 0)


func create_tilemap() -> void:
	var tilemap = $GridMap
	tilemap.clear()
	for x in range(tilemap_width):
		for z in range(tilemap_height):
			tilemap.set_cell_item(Vector3(x * tile_spacing, 0, z * tile_spacing), 1)  # Set the tile item to 1 or the appropriate tile index


func body_entered_tile(body: Node3D) -> void:
	if body is CharacterBody3D:
		Event.emit_signal("player_entered_tile")


func create_coins() -> void:
	for i in range(coin_spawn):
		var new_coin := coin.instantiate()
		new_coin.position = Vector3(
			randi_range(0, tilemap_width) * tile_spacing,
			coin_y_position,
			randi_range(0, tilemap_height) * tile_spacing
		)
		print("Coin position: ", new_coin.position)
		if new_coin.position not in coordinates:
			add_child(new_coin)
			coordinates.append(new_coin.position)


func create_obstacles() -> void:
	for i in range(coin_spawn / 3):
		var new_obstacle := obstacle.instantiate()
		new_obstacle.position = Vector3(
			randi_range(0, tilemap_width-1) * tile_spacing,
			obstacle_y_position,
			randi_range(0, tilemap_height-1) * tile_spacing
		)
		print("Obstacle position: ", new_obstacle.position)
		if new_obstacle.position not in coordinates:
			add_child(new_obstacle)
			coordinates.append(new_obstacle.position)
