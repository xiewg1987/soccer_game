class_name PlayerStatePreppingShot extends PlayerState


const DURATION_MAX_BONUS := 1000
const EASE_REWARD_FACTOR = 2.0


var shop_direction := Vector2.ZERO

var time_start_shot := Time.get_ticks_msec()

func _enter_tree() -> void:
	animation_player.play("prep_kick")
	palyer.velocity = Vector2.ZERO
	time_start_shot = Time.get_ticks_msec()


func _process(delta: float) -> void:
	shop_direction += KeyUnits.get_input_vector(palyer.control_scheme) * delta
	if KeyUnits.is_action_just_released(palyer.control_scheme, KeyUnits.Action.SHOOT):
		var duration_press = clampf(Time.get_ticks_msec() - time_start_shot, 0.0, DURATION_MAX_BONUS)
		var ease_time: float = duration_press / DURATION_MAX_BONUS
		var bonus := ease(ease_time, EASE_REWARD_FACTOR)
		var shop_power: float = palyer.power * (1 + bonus)
		shop_direction = shop_direction.normalized()
		var context_state_data = PlayerStateData.new()
		context_state_data.shop_direction = shop_direction
		context_state_data.shop_power = shop_power
		emit_state_transition_requested(Player.State.SHOTING, context_state_data)
