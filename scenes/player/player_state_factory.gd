class_name PlayerStateFactory extends RefCounted


var states: Dictionary


func _init() -> void:
	states = {
		Player.State.HEADER: PlayerStateHeader,
		Player.State.MOVING: PlayerStateMoving,
		Player.State.SHOTING: PlayerStateShoting,
		Player.State.PASSING: PlayerStatePassing,
		Player.State.TACKLING: PlayerStateTackling,
		Player.State.RECOVERING: PlayerStateRecovering,
		Player.State.VOLLRY_KICK: PlayerStateVollryKick,
		Player.State.BICYCLE_KICK: PlayerStateBicycleKick,
		Player.State.PREPPING_SHOT: PlayerStatePreppingShot,
	}


func get_fresh_state(state: Player.State) -> PlayerState:
	assert(states.has(state), "玩家 %s 状态不存在" % state)
	return states.get(state).new()
