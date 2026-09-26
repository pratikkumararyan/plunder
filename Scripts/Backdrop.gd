extends Sprite2D
@export var player: Node2D
@export var scrollFactor: Vector2 = Vector2(0.5, 0.5)

@export var minBounds: Vector2 = Vector2(-100, -50)
@export var maxBounds: Vector2 = Vector2(800, 300)

#copypasta from player script
#var speed = 200.0
#var jumpVelocity = -400.0
#var acceleration = 1500.0
#var friction = 1200.0
#const gravity = 980

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not player:
		return
		
	var targetPos = player.global_position * scrollFactor
	
	global_position.x = clamp(targetPos.x, minBounds.x, maxBounds.x)
	global_position.y = clamp(targetPos.y, minBounds.y, minBounds.y)
