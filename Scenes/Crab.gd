extends CharacterBody2D

const SPEED = 100.0

var target: Vector2
var going_to_pos2 := true

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	target = get_meta("Pos2")

func _physics_process(delta: float) -> void:
	global_position = global_position.move_toward(target, SPEED * delta)

	animated_sprite_2d.play("run")

	if target.x > global_position.x:
		animated_sprite_2d.flip_h = true
	elif target.x < global_position.x:
		animated_sprite_2d.flip_h = false

	if global_position == target:
		going_to_pos2 = !going_to_pos2
		target = get_meta("Pos2") if going_to_pos2 else get_meta("Pos1")
