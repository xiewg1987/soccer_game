class_name Player extends CharacterBody2D


enum ControlScheme { CPU, P1, P2}
enum State { MOVING, TACKLING}

@export var control_scheme: ControlScheme

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var player_sprite: Sprite2D = %PlayerSprite


var current_state: PlayerState = null
var state_factory := PlayerStateFactory.new()


func _ready() -> void:
	switch_state(Player.State.MOVING)


func _physics_process(_delta: float) -> void:
	file_sprite()
	move_and_slide()


func switch_state(state: State) -> void:
	if current_state != null:
		current_state.queue_free()
	current_state = state_factory.get_fresh_state(state)
	current_state.setup(self, animation_player)
	current_state.state_transition_requested.connect(switch_state)
	current_state.name = "PlayerStateMachine: %s" % state
	call_deferred("add_child", current_state)


func file_sprite() -> void:
	var direction := KeyUnits.get_input_vector(control_scheme)
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
