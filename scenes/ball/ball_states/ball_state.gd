class_name BallState extends Node

signal state_transition_requested(new_state: Ball.State)

const GRAVITY := 10.0

var ball: Ball = null
var carrier: Player = null


func setup(context_ball: Ball, context_carrier: Player) -> void:
	ball = context_ball
	carrier = context_carrier


func set_ball_animation_from_velocity() -> void:
	if ball.velocity == Vector2.ZERO:
		ball.animation_player.play("idle")
	elif ball.velocity.x > 0:
		ball.animation_player.play("roll")
		ball.animation_player.advance(0)
	else :
		ball.animation_player.play_backwards("roll")
		ball.animation_player.advance(0)


func process_gravity(delta: float, bounciness: float = 0.0) -> void:
	if  ball.height > 0 or ball.height_velocity > 0:
		ball.height_velocity -= GRAVITY * delta
		ball.height += ball.height_velocity
		if ball.height < 0:
			ball.height = 0
			if bounciness > 0.0 and ball.height_velocity < 0.0:
				ball.height_velocity = -ball.height_velocity * bounciness
				ball.velocity *= bounciness


func move_and_bounce(delta: float) -> void:
	var collision: KinematicCollision2D = ball.move_and_collide(ball.velocity * delta)
	if collision != null:
		ball.velocity = ball.velocity.bounce(collision.get_normal()) * ball.BOUNCINESS
		ball.switch_state(Ball.State.FREEFOEM)


func can_air_interact() -> bool:
	return false


func emit_state_transition_requested(new_state: Ball.State) -> void:
	state_transition_requested.emit(new_state)
