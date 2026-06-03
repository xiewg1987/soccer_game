class_name Player extends CharacterBody2D

enum ControlScheme { 
		CPU, 
		P1,
		P2
	}

enum Role {
	GOALIE,
	DEFENSE,
	MIDFIELD,
	OFFENSE,
}

enum SkinColor {
	LIGHT,
	MEDIUM,
	DARK,
}

enum State {
		HEADER,
		MOVING,
		PASSING,
		SHOTING,
		TACKLING,
		RECOVERING,
		VOLLRY_KICK,
		BICYCLE_KICK,
		CHEST_CONTROL,
		PREPPING_SHOT,
	}

const GRAVITY := 8.0
const BALL_CONTROL_HEIGHT_MAX := 10.0
const COUNTRIES := ["DEFAULT", "FRANCE", "ARGENTINA", "BRAZIL", "ENGLAND", "GERMANY", "ITALY", "SPAIN", "USA", "CANADA"]
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
var full_name := ""
var country := "DEFAULT"
var role := Role.MIDFIELD
var height_velocity := 0.0
var weight_on_duty_steering := 0.0
var skin_color := SkinColor.MEDIUM
var heading: Vector2 = Vector2.ZERO
var current_state: PlayerState = null
var spawn_position: Vector2 = Vector2.ZERO
var state_factory := PlayerStateFactory.new()
var ai_behavior: AIBehavior = AIBehavior.new()


func _ready() -> void:
	set_control_sprite()
	switch_state(State.MOVING)
	set_shader_properties()
	setup_ai_behavior()
	spawn_position = position

func _process(delta: float) -> void:
	file_sprite()
	move_and_slide()
	process_gravity(delta)
	set_sprite_visiblity()


func setup_ai_behavior() -> void:
	ai_behavior.setup(self, ball)
	ai_behavior.name = "AI Behavior"
	add_child(ai_behavior)


func set_shader_properties() -> void:
	player_sprite.material.set_shader_parameter("team_color", skin_color)
	player_sprite.material.set_shader_parameter("skin_color", max(COUNTRIES.find(country), 0))


func initialize(context_data: Dictionary) -> void:
	ball = context_data.ball
	country = context_data.country
	own_goal = context_data.own_goal
	position = context_data.position
	role = context_data.player_data.role
	target_goal = context_data.target_goal
	speed = context_data.player_data.speed
	power = context_data.player_data.power
	full_name = context_data.player_data.full_name
	skin_color = context_data.player_data.skin_color
	heading = Vector2.LEFT if target_goal.position.x < position.x else Vector2.RIGHT


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
	if heading.x > 0:
		player_sprite.flip_h = false
	elif heading.x < 0:
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


func control_ball() -> void:
	if ball.height > BALL_CONTROL_HEIGHT_MAX:
		switch_state(State.CHEST_CONTROL)


func has_ball() -> bool:
	return ball.carrier == self


func set_control_sprite() -> void:
	control_sprite.texture = CONTROL_SCHEME_MAP.get(control_scheme)


func set_sprite_visiblity() -> void:
	control_sprite.visible = has_ball() or not control_scheme == ControlScheme.CPU


func animation_complete() -> void:
	if current_state != null:
		current_state.animation_complete()
