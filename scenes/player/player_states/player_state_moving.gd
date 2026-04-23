class_name PlayerStateMoving extends PlayerState

func _process(_delta: float) -> void:
	if player.control_scheme == Player.ControlScheme.CPU: return
	handle_human_movement()
	player.set_movement_animation()


func handle_human_movement() -> void:
	var direction := KeyUnits.get_input_vector(player.control_scheme)
	var action_pass := KeyUnits.is_action_just_pressed(player.control_scheme, KeyUnits.Action.PASS)
	var action_shoot := KeyUnits.is_action_just_pressed(player.control_scheme, KeyUnits.Action.SHOOT)
	player.velocity = direction * player.speed
	
	if player.velocity != Vector2.ZERO:
		teammate_detectio_area.rotation = player.velocity.angle()
	
	if player.has_ball() :
		if action_pass:
			emit_state_transition_requested(Player.State.PASSING)
		elif action_shoot:
			emit_state_transition_requested(Player.State.PREPPING_SHOT)
	elif ball.can_air_interact() and action_shoot :
		if player.velocity == Vector2.ZERO:
			if is_facing_target_goal():
				emit_state_transition_requested(Player.State.VOLLRY_KICK)
			else :
				emit_state_transition_requested(player.State.BICYCLE_KICK)
		else :
			emit_state_transition_requested(Player.State.HEADER)


func is_facing_target_goal() -> bool:
	var direction_to_target_goal := player.position.direction_to(target_goal.position)
	return player.heading.dot(direction_to_target_goal) > 0
