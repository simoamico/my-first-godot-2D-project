extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_spawned: bool = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	animated_sprite.play('spawn')
	await animated_sprite.animation_finished
	is_spawned = true


func _physics_process(delta: float) -> void:
	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")
	
	if not is_spawned:
		return
	
	# Add the gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		audio_stream_player_2d.play()

	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	handle_animations(direction)

	# Play animations
func handle_animations(direction: int) -> void:
	handle_sprite_flip(direction)
	if is_on_floor():
		if direction == 0:
			animated_sprite.play('idle')
		else:
			animated_sprite.play('run')
	else:
		animated_sprite.play('jump')


	# Flip the Sprite
func handle_sprite_flip(direction: int) -> void:
	if direction > 0:
		animated_sprite.flip_h = false
	
	if direction < 0:
		animated_sprite.flip_h = true
