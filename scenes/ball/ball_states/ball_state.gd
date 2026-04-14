class_name BallState extends Node

signal state_transition_requested(new_state: Ball.State)

var carrier: Player = null
var ball: Ball = null
var player_detection_area: Area2D = null

func setup(context_ball: Ball, context_player_detection_area: Area2D, context_carrier: Player) -> void:
	ball = context_ball
	player_detection_area = context_player_detection_area
	carrier = context_carrier

func emit_state_transition_requested(new_state: Ball.State) -> void:
	state_transition_requested.emit(new_state)
