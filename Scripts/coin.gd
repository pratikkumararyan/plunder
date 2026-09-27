extends Area2D
@onready var animationPlayer = $AnimatedSprite2D
@onready var timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	PlayerStats.totalCoins += 1
	print(PlayerStats.totalCoins)
	timer.start()
	animationPlayer.play("effect")

func _on_timer_timeout() -> void:
	queue_free()
