extends AnimatableBody2D

@export var offset: Vector2 = Vector2(200, 0)
@export var duration: float = 4.0

var tween: Tween
var startPos: Vector2


func _ready() -> void:
	startPos = position


func _on_go_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if tween:
			tween.kill()

		var targetPos = startPos + offset

		tween = create_tween().set_loops().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(self, "position", targetPos, duration)
		tween.tween_property(self, "position", startPos, duration)


func _on_go_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		if tween:
			tween.kill()
			tween = null

		position = startPos
