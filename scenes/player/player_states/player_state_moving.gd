class_name PlayerStateMoving extends PlayerState

func _process(_delta: float) -> void:
	if player.control_scheme == Player.ControlScheme.CPU: return
	handle_human_movement()
	player.set_movement_animation()


func handle_human_movement() -> void:
	var direction := KeyUnits.get_input_vector(player.control_scheme)
	player.velocity = direction * player.speed
	
	if player.velocity != Vector2.ZERO:
		player.teammate_detectio_area.rotation = player.velocity.angle()
	
	if player.has_ball() and KeyUnits.is_action_just_pressed(player.control_scheme, KeyUnits.Action.PASS):
		emit_state_transition_requested(Player.State.PASSING)
	
	if player.has_ball() and KeyUnits.is_action_just_pressed(player.control_scheme, KeyUnits.Action.SHOOT):
		emit_state_transition_requested(Player.State.PREPPING_SHOT)
