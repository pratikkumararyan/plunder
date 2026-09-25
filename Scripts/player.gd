extends CharacterBody2D
var speed = 200.0
var jumpVelocity = -300.0
var acceleration = 1500.0
var friction = 1200.0
const gravity = 980

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jumpVelocity
	
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = move_toward(velocity.x, direction*speed, acceleration*delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction*delta)
	
	move_and_slide()
