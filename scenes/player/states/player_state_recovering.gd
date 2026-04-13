class_name PlayerStateRecovering extends PlayerState

const DURATION_RECOVER := 500

var time_start_recover := Time.get_ticks_msec()

func _enter_tree() -> void:
	time_start_recover = Time.get_ticks_msec()
	palyer.velocity = Vector2.ZERO
	animation_player.play("recover")


func _process(_delta: float) -> void:
	if Time.get_ticks_msec() - time_start_recover > DURATION_RECOVER:
		emit_state_transition_requested(Player.State.MOVING)
