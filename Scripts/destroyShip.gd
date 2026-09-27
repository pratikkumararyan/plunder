extends Node
@onready var timer = $Timer
@export var spawnShip: Node2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		spawnShip.play("damage")
		timer.start()

func _on_timer_timeout() -> void:
	spawnShip.queue_free()
		
