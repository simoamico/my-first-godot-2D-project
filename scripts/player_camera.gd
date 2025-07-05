extends Camera2D

@onready var tile_map: TileMap = $"../../TileMap"

func _ready() -> void:
	var map_rect = tile_map.get_used_rect()
	var tile_size = tile_map.cell_quadrant_size
	var world_size_in_pixels = map_rect.size * tile_size
	limit_right = world_size_in_pixels.x
	limit_bottom = world_size_in_pixels.y
