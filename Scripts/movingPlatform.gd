extends AnimatableBody2D

@export var offset: Vector2 = Vector2(200, 0)
@export var duration: float = 4.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var startPos = position
	var targetPos = startPos + offset
	
	var tween = create_tween().set_loops().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property(self, "position", targetPos, duration)
	tween.tween_property(self, "position", startPos, duration)

#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
