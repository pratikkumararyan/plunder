extends Area2D
@onready var animationPlayer = $AnimatedSprite2D
@onready var timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	timer.start()
	PlayerStats.health += 1
	animationPlayer.play("effect")

func _on_timer_timeout() -> void:
	queue_free()
