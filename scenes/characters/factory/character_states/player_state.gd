class_name PlayerState extends Node

signal state_transition_requested(new_state: Player.State)

var player: Player = null
var animation_player: AnimationPlayer = null

func setup(centext_player: Player) -> void:
	player = centext_player
	animation_player = centext_player.animation_player


func emit_state_transition_requested(new_state: Player.State) -> void:
	state_transition_requested.emit(new_state)
