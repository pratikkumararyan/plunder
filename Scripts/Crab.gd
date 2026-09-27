extends CharacterBody2D

const SPEED = 100.0
const GRAVITY = 980.0
const FOLLOW_DISTANCE = 70.0

var player: Node2D
var target: Vector2
var going_to_pos2 := true
var foundPlayer := false
var canAttack := true

@onready var attack_cooldown: Timer = $attackCooldown
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	target = get_meta("Pos2")

func _physics_process(delta: float) -> void:
	if foundPlayer:
		target = player.global_position

	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		velocity.y = 0

	if foundPlayer:
		var distance = abs(player.global_position.x - global_position.x)

		if distance > FOLLOW_DISTANCE:
			velocity.x = SPEED * sign(player.global_position.x - global_position.x)
			animated_sprite_2d.play("run")
		else:
			velocity.x = 0

			if canAttack:
				Attack()
	else:
		if abs(target.x - global_position.x) > 2.0:
			velocity.x = SPEED * sign(target.x - global_position.x)
			animated_sprite_2d.play("run")
		else:
			velocity.x = 0

	move_and_slide()

	if velocity.x > 0:
		animated_sprite_2d.flip_h = true
	elif velocity.x < 0:
		animated_sprite_2d.flip_h = false

	if abs(global_position.x - target.x) < 2.0 and !foundPlayer:
		going_to_pos2 = !going_to_pos2
		target = get_meta("Pos2") if going_to_pos2 else get_meta("Pos1")

func Attack() -> void:
	canAttack = false
	velocity.x = 0
	animated_sprite_2d.play("attack")
	player.health -= 5
	print(player.health)
	attack_cooldown.start()

func _on_inner_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		foundPlayer = true

func _on_outer_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		foundPlayer = false
		player = null
		target = get_meta("Pos2")

func _on_attack_cooldown_timeout() -> void:
	canAttack = true
