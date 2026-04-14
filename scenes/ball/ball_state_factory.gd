class_name BallStateFactory

var states: Dictionary


func _init() -> void:
	states = {
		Ball.State.CARRIED: BallStateCarried,
		Ball.State.FREEFOEM: BallStateFreeform,
		Ball.State.SHOT: BallStateShot
	}


func get_fresh_state(state: Ball.State) -> BallState:
	assert(states.has(state), "足球 %s 状态不存在" % state)
	return states.get(state).new()
