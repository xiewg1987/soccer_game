class_name PlayerState extends Node


signal state_transition_requested(new_state: Player.State, state_data: PlayerStateData)

var ball: Ball
var player: Player = null
var animation_player: AnimationPlayer
var teammate_detectio_area: Area2D
var ball_detection_area: Area2D
var state_data: PlayerStateData = PlayerStateData.new()


func setup(centext_player: Player, centext_state_data: PlayerStateData) -> void:
	ball = centext_player.ball
	player = centext_player
	state_data = centext_state_data
	animation_player = centext_player.animation_player
	ball_detection_area = centext_player.ball_detection_area
	teammate_detectio_area = centext_player.teammate_detectio_area


func emit_state_transition_requested(new_state: Player.State, new_state_data: PlayerStateData = PlayerStateData.new()) -> void:
	state_transition_requested.emit(new_state, new_state_data)


func animation_complete() -> void:
	pass
