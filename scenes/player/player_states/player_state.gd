class_name PlayerState extends Node


signal state_transition_requested(new_state: Player.State, state_data: PlayerStateData)


var player: Player = null
var state_data: PlayerStateData = PlayerStateData.new()

func setup(centext_player: Player, centext_state_data: PlayerStateData) -> void:
	player = centext_player
	state_data = centext_state_data


func animation_complete() -> void:
	pass


func emit_state_transition_requested(new_state: Player.State, new_state_data: PlayerStateData = PlayerStateData.new()) -> void:
	state_transition_requested.emit(new_state, new_state_data)
