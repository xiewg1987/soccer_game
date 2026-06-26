class_name BallStateFactory 

var states: Dictionary

func _init() -> void:
	states = {
		Ball.State.SHOT: BallStateShot,
		Ball.State.CARRIED: BallStateCarried,
		Ball.State.FREEFORM: BallStateFreeform,
	}

func get_fresh_state(state: Ball.State) -> BallState:
	assert(states.has(state), "足球 %s 状态不存在" % state)
	return states.get(state).new()
