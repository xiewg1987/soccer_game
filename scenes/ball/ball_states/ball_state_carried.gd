class_name BallStateCarried extends BallState

var DRIBBLE_FREQUENCY: float = 8.0
var DRIBBLE_INTENSITY: float = 4.0

const OFFSET_FROM_PLAYER := Vector2(6.0, 2.0)

var dribble_time: float = 0.0

func _enter_tree() -> void:
	assert(carrier != null, "带球玩家不能为空")


func _process(delta: float) -> void:
	var vx = 0.0
	var offset_y = OFFSET_FROM_PLAYER.y
	var offset_x = carrier.heading.x * OFFSET_FROM_PLAYER.x
	dribble_time += delta
	if carrier.velocity != Vector2.ZERO:
		if carrier.velocity.x != 0:
			vx = cos(dribble_time * DRIBBLE_FREQUENCY) * DRIBBLE_INTENSITY
		if carrier.heading.x  >= 0:
			animation_player.play("roll")
			animation_player.advance(0)
		else :
			animation_player.play_backwards("roll")
			animation_player.advance(0)
	else :
		animation_player.play("idle")
	ball.position = carrier.position + Vector2(offset_x + vx, offset_y)
