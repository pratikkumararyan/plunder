extends CharacterBody2D

var health = 30
const SPEED = 100.0
const GRAVITY = 980.0
const FOLLOW_DISTANCE = 70.0
const ATTACK_DAMAGE = 20.0

@export var pos1: Vector2
@export var pos2: Vector2
@export var innerRange: float = 50.0
@export var outerRange: float = 100.0

var player: Node2D
var target: Vector2
var going_to_pos2 := true
var foundPlayer := false
var canAttack := true
var dead := false

@onready var attack_cooldown: Timer = $attackCooldown
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	target = pos2
	$innerRange/CollisionShape2D.shape.radius = innerRange
	$outerRange/CollisionShape2D.shape.radius = outerRange

func _physics_process(delta: float) -> void:
	if dead:
		return
		
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
		target = pos2 if going_to_pos2 else pos1

func Attack() -> void:
	canAttack = false
	velocity.x = 0
	PlayerStats.health -= ATTACK_DAMAGE
	animated_sprite_2d.play("attack")
	attack_cooldown.start()
	
func TakeDamage(amount: int) -> void:
	if dead:
		return

	health -= amount
	animated_sprite_2d.play("hit")
	print("damage taken")

	if health <= 0:
		Die()
	
func Die() -> void:
	dead = true
	canAttack = false
	velocity = Vector2.ZERO
	$CollisionShape2D.queue_free()
	animated_sprite_2d.play("dead_ground")

func _on_inner_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		foundPlayer = true

func _on_outer_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		foundPlayer = false
		player = null
		target = pos2

func _on_attack_cooldown_timeout() -> void:
	canAttack = true
