extends Area2D
@onready var animationPlayer = $AnimatedSprite2D
@onready var timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	print(body.money)
	body.money += 10
	print(body.money)
	timer.start()
	animationPlayer.play("effect")

func _on_timer_timeout() -> void:
	queue_free()
