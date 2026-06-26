class_name BallStateCarried extends BallState

const DRIBBLE_FREQUECY := 10.0
const DRIBBLE_INTENSITY := 4.0
const OFFSET_FROM_PLAYER: Vector2 = Vector2(8.0, 3.0)


var dirbble_time := 0.0


func _enter_tree() -> void:
	assert(carrier != null, "携带者不能为空！")


func _process(delta: float) -> void:
	var vx := 0.0
	dirbble_time += delta
	if carrier.velocity != Vector2.ZERO:
		if carrier.heading.x != 0:
			vx = cos(DRIBBLE_FREQUECY * dirbble_time) * DRIBBLE_INTENSITY
		if carrier.heading.x >= 0:
			animation_player.play("roll")
			animation_player.advance(0)
		else :
			animation_player.play_backwards("roll")
			animation_player.advance(0)
	else :
		animation_player.play("idle")
	var offset_y = OFFSET_FROM_PLAYER.y
	var offset_x = vx + (carrier.heading.x * OFFSET_FROM_PLAYER.x)
	ball.position = carrier.position + Vector2(offset_x, offset_y)
