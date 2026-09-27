extends CharacterBody2D

const SPEED = 100.0
const GRAVITY = 980.0

var target: Vector2
var going_to_pos2 := true
var foundPlayer := false
var player: Node2D

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

	if abs(target.x - global_position.x) > 2.0:
		velocity.x = SPEED * sign(target.x - global_position.x)
	else:
		velocity.x = 0

	move_and_slide()

	animated_sprite_2d.play("run")

	if velocity.x > 0:
		animated_sprite_2d.flip_h = true
	elif velocity.x < 0:
		animated_sprite_2d.flip_h = false

	if abs(global_position.x - target.x) < 2.0 and !foundPlayer:
		going_to_pos2 = !going_to_pos2
		target = get_meta("Pos2") if going_to_pos2 else get_meta("Pos1")

func _on_inner_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		foundPlayer = true

func _on_outer_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		foundPlayer = false
		player = null
		target = get_meta("Pos2")
