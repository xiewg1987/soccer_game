class_name BallState extends Node

signal state_transition_requested(new_state: Ball.State)


var ball: Ball = null
var carrier: Player = null
var player_detection_area: Area2D = null
var animation_player: AnimationPlayer = null


func setup(context_ball: Ball, context_player_detection_area: Area2D, context_animation_player: AnimationPlayer, context_carrier: Player) -> void:
	ball = context_ball
	player_detection_area = context_player_detection_area
	carrier = context_carrier
	animation_player = context_animation_player


func set_ball_animation_from_velocity() -> void:
	if ball.velocity == Vector2.ZERO:
		animation_player.play("idle")
	elif ball.velocity.x > 0:
		animation_player.play("roll")
		animation_player.advance(0)
	else :
		animation_player.play_backwards("roll")
		animation_player.advance(0)


func emit_state_transition_requested(new_state: Ball.State) -> void:
	state_transition_requested.emit(new_state)
