class_name PlayerStatePassing extends PlayerState


func _enter_tree() -> void:
	player.animation_player.play("kick")
	player.velocity = Vector2.ZERO


func animation_complete() -> void:
	var pass_target := find_teammate_in_view()
	var target := Vector2.ZERO
	if pass_target == null:
		target = player.ball.position + player.heading * player.speed
	else :
		target = pass_target.position + pass_target.velocity
	player.ball.pass_to(target)
	emit_state_transition_requested(Player.State.MOVING)


func find_teammate_in_view() -> Player:
	var players_in_view = player.teammate_detectio_area.get_overlapping_bodies()
	var teammate_in_view = players_in_view.filter(func (p: Player): return p != player)
	teammate_in_view.sort_custom(func (p1: Player, p2: Player):
		var distance1 = p1.position.distance_squared_to(player.position)
		var distance2 = p2.position.distance_squared_to(player.position)
		return distance1 < distance2
	)
	if teammate_in_view.size() > 0:
		return teammate_in_view[0]
	return null
