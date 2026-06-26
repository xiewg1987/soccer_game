class_name PlayerStateRecovering extends PlayerState

const DURATION_RECOVERY := 500

var time_state_recovery := Time.get_ticks_msec()

func _enter_tree() -> void:
	animation_player.play("recover")
	player.velocity = Vector2.ZERO
	time_state_recovery = Time.get_ticks_msec()

func _process(_delta: float) -> void:
	if Time.get_ticks_msec() - time_state_recovery > DURATION_RECOVERY:
		emit_state_transition_requested(Player.State.MOVING)
