extends Button

func _pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
	PlayerStats.totalCoins = -4
	PlayerStats.health = 100
