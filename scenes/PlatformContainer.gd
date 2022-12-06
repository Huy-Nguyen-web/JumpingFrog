extends Spatial

var next_tile_position = 0

func _ready():
	randomize()
	_on_Player_create_platform()


func _on_Player_create_platform():
	var platform = preload("res://scenes/Platform.tscn").instance()
	
	next_tile_position -= rand_range(7, 17)
	platform.transform.origin = Vector3(0, 0, next_tile_position)
	platform.rotation_degrees.y = rand_range(0, 360)
#	tween.interpolate_property(platform, "translation", Vector3(0, -2, next_tile_position), Vector3(0, 0, next_tile_position), 0.3)
	add_child(platform)
	
	
	
func _process(delta):
	pass

