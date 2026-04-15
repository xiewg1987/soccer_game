class_name PlayerStateShoting extends PlayerState


func _enter_tree() -> void:
	animation_player.play("kick")


func animation_complete() -> void:
	if palyer.control_scheme == Player.ControlScheme.CPU:
		emit_state_transition_requested(Player.State.RECOVERING)
	else :
		emit_state_transition_requested(Player.State.MOVING)
	shoot_ball()


func shoot_ball() -> void:
	print("射门角度 %s 强度 %s" % [state_data.shop_direction, state_data.shop_power])
	palyer.ball.shoot(state_data.shop_direction *  state_data.shop_power)
