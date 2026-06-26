class_name Ball extends AnimatableBody2D

enum State {CARRIED, FREEFORM, SHOT}

@onready var player_detection_area: Area2D = %PlayerDetectionArea

var carrier: Player = null
var velocity := Vector2.ZERO
var current_state: BallState = null
var state_factory := BallStateFactory.new()

func _ready() -> void:
	switch_states(State.FREEFORM)

func switch_states(state: State) -> void:
	if current_state != null:
		current_state.queue_free()
	current_state = state_factory.get_fresh_state(state)
	current_state.setup(self)
	current_state.state_transition_requested.connect(switch_states)
	current_state.name = "BallStateMachine: %s" % state
	call_deferred("add_child", current_state)
