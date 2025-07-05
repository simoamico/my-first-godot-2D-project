extends Node2D


const SPEED = 60

var direction = 1
var is_spawned : bool = false

@onready var ray_cast_2d_right: RayCast2D = $RayCast2DRight
@onready var ray_cast_2d_left: RayCast2D = $RayCast2DLeft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite.play('spawn')
	await animated_sprite.animation_finished
	is_spawned = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_spawned:
		return

	animated_sprite.play('walk')
	if ray_cast_2d_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true;
	if ray_cast_2d_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false;
	position.x += direction * SPEED * delta
