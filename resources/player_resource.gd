class_name PlayerResource extends Resource


@export var full_name: String
@export var skin_color: Player.SkinColor
@export var role: Player.Role
@export var speed: float
@export var power: float



func _init(player_context: Dictionary) -> void:
	role = player_context.role
	speed = player_context.speed
	power = player_context.power
	full_name = player_context.full_name
	skin_color = player_context.skin_color
