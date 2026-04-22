class_name Ball extends AnimatableBody2D

enum State {CARRIED, FREEFOEM, SHOT}


@export var friction_air: float
@export var friction_ground: float

@onready var player_detection_area: Area2D = %PlayerDetectionArea
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var ball_sprite: Sprite2D = %BallSprite


var carrier: Player = null
var velocity := Vector2.ZERO
var height := 0.0
var height_velocity := 0.0
var current_state: BallState = null
var state_factory: BallStateFactory = BallStateFactory.new()


func _ready() -> void:
	switch_state(State.FREEFOEM)


func _process(_delta: float) -> void:
	ball_sprite.position = Vector2.UP * height

func switch_state(state: State) -> void:
	if current_state != null:
		current_state.queue_free()
	current_state = state_factory.get_fresh_state(state)
	current_state.setup(self, player_detection_area,animation_player, carrier)
	current_state.state_transition_requested.connect(switch_state)
	current_state.name = "足球状态机: %s" % state
	call_deferred("add_child", current_state)

func shoot(shot_velocity: Vector2) -> void:
	carrier = null
	velocity = shot_velocity
	switch_state(State.SHOT)


func pass_to(destiantion: Vector2) -> void:
	var direction = position.direction_to(destiantion)
	var distance = position.distance_to(destiantion)
	var intensity = sqrt(2 * distance * friction_ground)
	carrier = null
	velocity = direction * intensity
	switch_state(State.FREEFOEM)
