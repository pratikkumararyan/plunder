extends Node2D
#copypasta from player script
var speed = 200.0
var jumpVelocity = -400.0
var acceleration = 1500.0
var friction = 1200.0
const gravity = 980


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	const player: CharacterBody2D = get_node("Player")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
