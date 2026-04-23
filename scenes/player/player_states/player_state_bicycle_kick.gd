class_name PlayerStateBicycleKick extends PlayerState

const BONUS_POWER := 1.4

var air_connect_min_height: float = 5.0
var air_connect_max_height: float = 25.0

func _enter_tree() -> void:
	animation_player.play("bicycle_kick")
	ball_detection_area.body_entered.connect(on_ball_entered)


func on_ball_entered(contact_ball: Ball) -> void:
	if contact_ball.can_air_connect(air_connect_min_height, air_connect_max_height):
		var destination := target_goal.get_random_traget_position()
		var direction := ball.position.direction_to(destination)
		contact_ball.shoot(direction * player.power * BONUS_POWER)


func animation_complete() -> void:
	emit_state_transition_requested(Player.State.RECOVERING)
