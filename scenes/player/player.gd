class_name Player extends CharacterBody2D

enum ControlScheme { 
		CPU, 
		P1,
		P2
	}

enum State { 
		MOVING,
		PASSING, 
		TACKLING, 
		RECOVERING, 
		PREPPING_SHOT, 
		SHOTING,
		HEADER,
		VOLLRY_KICK,
		BICYCLE_KICK
	}

const GRAVITY := 8.0
const CONTROL_SCHEME_MAP: Dictionary = {
	ControlScheme.CPU: preload("uid://dhc7dno5yhs0s"),
	ControlScheme.P1: preload("uid://d0xglgnndh63e") ,
	ControlScheme.P2: preload("uid://cw6lyibgglni3")
}

@export var ball: Ball
@export var power: float
@export var speed: float
@export var own_goal: Goal
@export var target_goal: Goal
@export var control_scheme: ControlScheme

@onready var player_sprite: Sprite2D = %PlayerSprite
@onready var control_sprite: Sprite2D = %ControlSprite
@onready var ball_detection_area: Area2D = %BallDetectionArea
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var teammate_detectio_area: Area2D = %TeammateDetectioArea

var height := 0.0
var height_velocity := 0.0
var heading: Vector2 = Vector2.ZERO
var current_state: PlayerState = null
var state_factory := PlayerStateFactory.new()


func _ready() -> void:
	set_control_sprite()
	switch_state(State.MOVING)


func _process(delta: float) -> void:
	file_sprite()
	move_and_slide()
	process_gravity(delta)
	set_sprite_visiblity()


func switch_state(state: State, state_data: PlayerStateData = PlayerStateData.new()) -> void:
	if current_state != null:
		current_state.queue_free()
	current_state = state_factory.get_fresh_state(state)
	current_state.setup(self, state_data)
	current_state.state_transition_requested.connect(switch_state)
	current_state.name = "玩家状态机: %s" % state
	call_deferred("add_child", current_state)


func file_sprite() -> void:
	var direction := KeyUnits.get_input_vector(control_scheme)
	if direction != Vector2.ZERO:
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


func process_gravity(delta: float) -> void:
	if height > 0:
		height_velocity -= GRAVITY * delta
		height += height_velocity
		if height < 0: height = 0
	player_sprite.position = Vector2.UP * height
			

func has_ball() -> bool:
	return ball.carrier == self


func set_control_sprite() -> void:
	control_sprite.texture = CONTROL_SCHEME_MAP.get(control_scheme)


func set_sprite_visiblity() -> void:
	control_sprite.visible = has_ball() or not control_scheme == ControlScheme.CPU


func animation_complete() -> void:
	if current_state != null:
		current_state.animation_complete()
