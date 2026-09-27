extends Control
@onready var counter = $counter


func _process(delta: float) -> void:
	counter.text = "x"+str(PlayerStats.totalCoins)
