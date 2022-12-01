extends RigidBody

var gravity := 8.0
var jump_power := 2.0
var on_ground := false
var start_position : Vector3
var die := false
var tutorial := true

const MAX_JUMP_POWER = 12

signal create_platform


func _ready():
	start_position = translation


func _physics_process(delta : float):
	if Input.is_action_pressed("jump") and on_ground:
		jump_power += 10 * delta
		if jump_power >= MAX_JUMP_POWER:
			jump_power = MAX_JUMP_POWER
			
		if tutorial:
			$"../Control/AnimationPlayer".play("tutorial_fade_out")
			tutorial = false
		
	if Input.is_action_just_released("jump") and on_ground:
		jump()
		
	if not die:
		if translation.y <= 0:
			# When player die
			game_over()
		else:
			# The water shader will follow the player,
			# making the illusion of the endless water.
			$"../WaterShader".translation.z = translation.z


	# The jump power start with 2 instead of 0 (for the game feel)
	$"../Control/PowerBar".value = (jump_power-2)/(MAX_JUMP_POWER-2) * 100
	$"../Control/Score".text = str(Global.score)

func jump():
	apply_central_impulse(Vector3(0, jump_power * 2, -jump_power))
	jump_power = 2
	on_ground = false
	$AnimationPlayer.play("jump")
	$JumpSound.play(0.3)
	


func _on_Player_body_entered(body):
	on_ground = true
	$LandSound.play(0.1)
	if body.is_in_group("platform") and not body.get_parent().name == "StartPlatform" and not body.has_been_triggered and translation.y - 1 > 0:
		body.has_been_triggered = true
		Global.score += 1
		emit_signal("create_platform")


func _on_PlayAgainButton_pressed():
	Global.score = 0
	get_tree().change_scene("res://scenes/World.tscn")

	
func game_over():
	if Global.score > Global.highscore:
		Global.highscore = Global.score
		Global.save_highscore()
			

	$Camera.follow_player = false
	$"../Popup".popup_centered()
	$"../Popup/VBoxContainer/Score".text = str(Global.score)
	$"../Popup/VBoxContainer/Highscore".text = str(Global.highscore)
	$SplashSound.play(0.17)
	die = true


