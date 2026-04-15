class_name BallStateFreeform extends BallState


func _enter_tree() -> void:
	player_detection_area.body_entered.connect(_on_player_entered)


func _on_player_entered(body: Node2D) -> void:
	if not body is Player: return
	ball.carrier = body
	emit_state_transition_requested(Ball.State.CARRIED)


func _process(delta: float) -> void:
	set_ball_animation_from_velocity()
	ball.move_and_collide(ball.velocity * delta)
