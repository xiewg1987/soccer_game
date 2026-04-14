class_name BallStateCarried extends BallState


func _enter_tree() -> void:
	assert(carrier != null, "带球玩家不能为空")


func _process(_delta: float) -> void:
	ball.position = carrier.position
