extends CharacterBody2D

var speed = 200.0
var jump_velocity = -400.0
var acceleration = 1500.0
var friction = 1200.0
var money = 0
var health = 100
const gravity = 980

var defaultShootRange = 1
var currentShootRange = defaultShootRange

var shot: bool = false

var last_direction: Vector2 = Vector2.LEFT
var was_on_floor = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const THROWABLE_COIN = preload("uid://cleb4u60w66dx")
@onready var shoot_direction: Marker2D = $ShootDirection
@onready var shoot_cooldown: Timer = $ShootCooldown
@onready var trajectory: Line2D = $Trajectory

func _physics_process(delta: float) -> void:
	var was_falling = velocity.y > 0

	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jump_velocity
		play_animation("jump", last_direction)
		
	if Input.is_action_pressed("Shoot") and !shot and (PlayerStats.totalCoins > 0):
		currentShootRange = min(currentShootRange + 2.0 * delta, 5.0)
		update_trajectory()
		trajectory.visible = true
		
	if Input.is_action_just_released("Shoot") and !shot and (PlayerStats.totalCoins > 0):
		trajectory.visible = false

		shot = true
		
		shoot_cooldown.start()
		PlayerStats.totalCoins -= 1
		
		var coin = THROWABLE_COIN.instantiate()
		get_tree().current_scene.add_child(coin)

		coin.global_position = shoot_direction.global_position
		coin.linear_velocity = Vector2(
			last_direction.x * 300 * currentShootRange,
			-200 * currentShootRange
		)
		
		currentShootRange = defaultShootRange
	
	process_movement(delta)
	move_and_slide()

	# Landing
	if not was_on_floor and is_on_floor():
		play_animation("ground", last_direction)

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
		if dir.x < 0:
			shoot_direction.position.x = -9.5
		else: 
			shoot_direction.position.x = 9.5

	if animated_sprite_2d.animation != prefix:
		animated_sprite_2d.play(prefix)

func update_trajectory() -> void:
	trajectory.clear_points()

	var start = shoot_direction.global_position
	var shoot_velocity = Vector2(
		last_direction.x * 300 * currentShootRange,
		-200 * currentShootRange
	)

	var space_state = get_world_2d().direct_space_state

	var previous_point = start

	for i in range(30):
		var t = i * 0.05
		var point = start + shoot_velocity * t + Vector2(0, 0.5 * gravity * t * t)

		var query = PhysicsRayQueryParameters2D.create(
			previous_point,
			point
		)

		query.exclude = [self]

		var result = space_state.intersect_ray(query)

		if result:
			trajectory.add_point(trajectory.to_local(result.position))
			break

		trajectory.add_point(trajectory.to_local(point))
		previous_point = point

func _on_shoot_cooldown_timeout() -> void:
	shot = false
