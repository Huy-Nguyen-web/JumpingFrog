extends StaticBody

var has_been_triggered = false

func _ready():
	bounce = 0

func _on_VisibilityNotifier_screen_exited():
	if not get_parent().name == "StartPlatform":
		get_parent().queue_free()

