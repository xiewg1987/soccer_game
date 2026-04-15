class_name BallStateShot extends BallState

const DURATION_SHOP := 1000
const SHOP_HEIGHT := 5.0
const SHOP_SPRITE_SCALE := 0.8


var time_since_shop := Time.get_ticks_msec()


func _enter_tree() -> void:
	time_since_shop = Time.get_ticks_msec()
	set_ball_animation_from_velocity()
	ball.ball_sprite.position = Vector2.UP * SHOP_HEIGHT
	ball.ball_sprite.scale.y = SHOP_SPRITE_SCALE


func _process(delta: float) -> void:
	ball.move_and_collide(ball.velocity * delta)
	if Time.get_ticks_msec() - time_since_shop > DURATION_SHOP:
		emit_state_transition_requested(Ball.State.FREEFOEM)


func _exit_tree() -> void:
	ball.ball_sprite.scale.y = 1.0
