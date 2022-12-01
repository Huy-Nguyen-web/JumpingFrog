extends Camera

export var distance : float = 6
export var height : float = 2

var follow_player = true

func _ready():
	set_physics_process(true)
	set_as_toplevel(true)



func _physics_process(delta):
	if follow_player:
		follow()
	
	
	
func follow():
	var target = get_parent().get_global_transform().origin
	var pos = get_global_transform().origin
	var up = Vector3.UP
	
	var offset = pos - target
	
	offset = offset.normalized() * distance
	offset.y = height
	
	pos = target + offset
	
	look_at_from_position(pos, target, up)
