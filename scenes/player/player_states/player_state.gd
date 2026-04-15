class_name PlayerState extends Node


signal state_transition_requested(new_state: Player.State, state_data: PlayerStateData)


var palyer: Player = null
var state_data: PlayerStateData = PlayerStateData.new()
var animation_player: AnimationPlayer

func setup(centext_player: Player, centext_state_data: PlayerStateData, centext_animation_player: AnimationPlayer) -> void:
	palyer = centext_player
	state_data = centext_state_data
	animation_player = centext_animation_player


func animation_complete() -> void:
	pass


func emit_state_transition_requested(new_state: Player.State, new_state_data: PlayerStateData = PlayerStateData.new()) -> void:
	state_transition_requested.emit(new_state, new_state_data)
