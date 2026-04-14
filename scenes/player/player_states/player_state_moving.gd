class_name PlayerStateMoving extends PlayerState

@export var speed: float = 80.0

func _process(_delta: float) -> void:
	if palyer.control_scheme == Player.ControlScheme.CPU: return
	handle_human_movement()
	palyer.set_movement_animation()


func handle_human_movement() -> void:
	var direction := KeyUnits.get_input_vector(palyer.control_scheme)
	palyer.velocity = direction * speed
	if palyer.velocity != Vector2.ZERO and KeyUnits.is_action_just_pressed(palyer.control_scheme, KeyUnits.Action.SHOOT):
		emit_state_transition_requested(Player.State.TACKLING)
