class_name PlayerState extends Node


signal state_transition_requested(new_state: Player.State, state_data: PlayerStateData)

var ball: Ball
var own_goal: Goal
var target_goal: Goal
var player: Player = null
var ball_detection_area: Area2D
var teammate_detectio_area: Area2D
var animation_player: AnimationPlayer
var state_data: PlayerStateData = PlayerStateData.new()


func setup(centext_player: Player, centext_state_data: PlayerStateData) -> void:
	player = centext_player
	ball = centext_player.ball
	state_data = centext_state_data
	own_goal = centext_player.own_goal
	target_goal = centext_player.target_goal
	animation_player = centext_player.animation_player
	ball_detection_area = centext_player.ball_detection_area
	teammate_detectio_area = centext_player.teammate_detectio_area


func emit_state_transition_requested(new_state: Player.State, new_state_data: PlayerStateData = PlayerStateData.new()) -> void:
	state_transition_requested.emit(new_state, new_state_data)


func animation_complete() -> void:
	pass
