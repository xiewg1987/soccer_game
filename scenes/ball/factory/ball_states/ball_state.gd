class_name BallState extends Node

signal state_transition_requested(new_state: Ball.State)


var ball: Ball = null
var carrier: Player = null
var player_detection_area: Area2D = null


func setup(centext_ball: Ball) -> void:
	ball = centext_ball
	carrier = centext_ball.carrier
	player_detection_area = centext_ball.player_detection_area	


func emit_state_transition_requested(new_state: Ball.State) -> void:
	state_transition_requested.emit(new_state)
