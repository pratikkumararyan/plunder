extends CharacterBody2D

var speed = 200.0
var jump_velocity = -400.0
var acceleration = 1500.0
var friction = 1200.0
const gravity = 980

var last_direction: Vector2 = Vector2.LEFT
var was_on_floor = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	var was_falling = velocity.y > 0

	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jump_velocity
		play_animation("jump", last_direction)

	process_movement(delta)
	move_and_slide()

	# Landing
	if not was_on_floor and is_on_floor():
		play_animation("land", last_direction)

	# Air animations
	elif not is_on_floor():
		if velocity.y < 0:
			play_animation("jump", last_direction)
		else:
			play_animation("fall", last_direction)

	was_on_floor = is_on_floor()


func process_movement(delta: float) -> void:
	var direction := Input.get_axis("MoveLeft", "MoveRight")

	if direction != 0:
		velocity.x = move_toward(velocity.x, direction * speed, acceleration * delta)
		last_direction = Vector2(direction, 0)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)

	if is_on_floor():
		process_animation(last_direction)


func process_animation(direction: Vector2) -> void:
	if velocity.x != 0:
		play_animation("run", direction)
	else:
		play_animation("default", direction)


func play_animation(prefix: String, dir: Vector2) -> void:
	if dir.x != 0:
		animated_sprite_2d.flip_h = dir.x < 0

	if animated_sprite_2d.animation != prefix:
		animated_sprite_2d.play(prefix)
