class_name PlayerStateFactory extends RefCounted


var states: Dictionary


func _init() -> void:
	states = {
		Player.State.MOVING: PlayerStateMoving,
		Player.State.SHOTING: PlayerStateShoting,
		Player.State.TACKLING: PlayerStateTackling,
		Player.State.RECOVERING: PlayerStateRecovering,
		Player.State.PREPPING_SHOT: PlayerStatePreppingShot,
	}


func get_fresh_state(state: Player.State) -> PlayerState:
	assert(states.has(state), "玩家 %s 状态不存在" % state)
	return states.get(state).new()
