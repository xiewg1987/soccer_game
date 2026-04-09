class_name Player extends CharacterBody2D


enum ControlScheme { CPU, P1, P2}

@export var control_scheme: ControlScheme
@export var speed: float = 80.0

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var player_sprite: Sprite2D = %PlayerSprite


func _physics_process(_delta: float) -> void:
	if control_scheme == ControlScheme.CPU: return
	var direction := KeyUnits.get_input_vector(control_scheme)
	velocity = direction * speed
	file_sprite(direction)
	set_movement_animation(direction)
	move_and_slide()


func file_sprite(direction: Vector2) -> void:
	if direction.x > 0:
		player_sprite.flip_h = false
	elif direction.x < 0:
		player_sprite.flip_h = true


func set_movement_animation(direction: Vector2) -> void:
	if direction != Vector2.ZERO:
		animation_player.play("run")
	else :
		animation_player.play("idle")
