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
