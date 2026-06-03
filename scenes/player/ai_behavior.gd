class_name AIBehavior extends Node

const BURATION_AI_TICK_FREQUENCY := 200

var ball: Ball
var player: Player
var time_since_time_tick := Time.get_ticks_msec()

func _ready() -> void:
	time_since_time_tick = Time.get_ticks_msec() + randi_range(0, BURATION_AI_TICK_FREQUENCY)

func setup( context_player: Player, context_ball: Ball) -> void:
	ball = context_ball
	player = context_player


func process_ai() -> void:
	if  Time.get_ticks_msec() - time_since_time_tick > BURATION_AI_TICK_FREQUENCY:
		time_since_time_tick = Time.get_ticks_msec()
		preform_ai_movement()
		preform_ai_decisions()


func preform_ai_movement() -> void:
	var total_streeing_force := Vector2.ZERO
	total_streeing_force += get_onduty_steering_force()
	total_streeing_force = total_streeing_force.limit_length(1.0)
	player.velocity = total_streeing_force * player.speed


func preform_ai_decisions() -> void:
	pass


func get_onduty_steering_force() -> Vector2:
	return player.weight_on_duty_steering * player.position.direction_to(ball.position)
	
