class_name PlayerState extends Node


signal state_transition_requested(new_state: Player.State)


var palyer: Player = null
var animation_player: AnimationPlayer

func setup(centext_player: Player, centext_animation_player: AnimationPlayer) -> void:
	palyer = centext_player
	animation_player = centext_animation_player


func emit_state_transition_requested(new_state: Player.State) -> void:
	state_transition_requested.emit(new_state)
