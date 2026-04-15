class_name Player extends CharacterBody2D


enum ControlScheme { CPU, P1, P2}
enum State { MOVING, TACKLING, RECOVERING, PREPPING_SHOT, SHOTING}

@export var ball: Ball
@export var power: float
@export var speed: float = 80.0
@export var control_scheme: ControlScheme

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var player_sprite: Sprite2D = %PlayerSprite

var heading: Vector2 = Vector2.ZERO
var current_state: PlayerState = null
var state_factory := PlayerStateFactory.new()


func _ready() -> void:
	switch_state(State.MOVING)


func _physics_process(_delta: float) -> void:
	file_sprite()
	move_and_slide()


func switch_state(state: State, state_data: PlayerStateData = PlayerStateData.new()) -> void:
	if current_state != null:
		current_state.queue_free()
	current_state = state_factory.get_fresh_state(state)
	current_state.setup(self, state_data, animation_player)
	current_state.state_transition_requested.connect(switch_state)
	current_state.name = "玩家状态机: %s" % state
	call_deferred("add_child", current_state)


func file_sprite() -> void:
	var direction := KeyUnits.get_input_vector(control_scheme)
	heading = direction
	if direction.x > 0:
		player_sprite.flip_h = false
	elif direction.x < 0:
		player_sprite.flip_h = true


func set_movement_animation() -> void:
	var direction := KeyUnits.get_input_vector(control_scheme)
	if direction != Vector2.ZERO:
		animation_player.play("run")
	else :
		animation_player.play("idle")


func has_ball() -> bool:
	return ball.carrier == self


func animation_complete() -> void:
	if current_state != null:
		current_state.animation_complete()
