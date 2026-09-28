extends Sprite2D

var startScaleY: float
var speed: float = PlayerStats.waterRiseSpeed
var acceleration: float = PlayerStats.waterRiseAcc

func _ready() -> void:
	startScaleY = scale.y

func _process(delta: float) -> void:
	speed += acceleration * delta
	scale.y += speed * delta

	var heightIncrease = (scale.y - startScaleY) * texture.get_height()
	$"../waterTop".position.y = 1002.0 - heightIncrease


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		PlayerStats.health -= 100
