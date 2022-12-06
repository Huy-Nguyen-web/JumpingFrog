extends KinematicBody

var has_been_triggered = false

func _ready():
#	bounce = 0
	var tween := get_tree().create_tween()
	if not get_parent().name == "StartPlatform":
		tween.tween_property(get_parent(), "position:y", 2, 0.5)

func _on_VisibilityNotifier_screen_exited():
	if not get_parent().name == "StartPlatform":
		get_parent().queue_free()
		

