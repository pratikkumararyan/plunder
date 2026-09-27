extends Node
@export var spawnShip: Node2D
@export var shrinkDuration: float = 1.0

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		spawnShip.play("damage")
		
		var tween = create_tween()
		tween.tween_property(spawnShip, "scale", Vector2.ZERO, shrinkDuration).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
		tween.tween_callback(spawnShip.queue_free)
		tween.tween_callback(queue_free)
