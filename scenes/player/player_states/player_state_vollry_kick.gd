class_name PlayerStateVollryKick extends PlayerState

const BONUS_POWER := 1.5

var air_connect_min_height: float = 1.0
var air_connect_max_height: float = 20.0

func _enter_tree() -> void:
	animation_player.play("volley_kick")
	ball_detection_area.body_entered.connect(on_ball_entered)


func on_ball_entered(contact_ball: Ball) -> void:
	if contact_ball.can_air_connect(air_connect_min_height, air_connect_max_height):
		var destination := target_goal.get_random_traget_position()
		var direction := ball.position.direction_to(destination)
		contact_ball.shoot(direction * player.power * BONUS_POWER)


func animation_complete() -> void:
	emit_state_transition_requested(Player.State.RECOVERING)
