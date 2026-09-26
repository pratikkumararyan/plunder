@tool
extends HFlowContainer

@export_dir var lettersFolder: String = "res://Assets/Wood and paper UI/Sprites/Small Text/Small Text"

@export_multiline var text: String = "HELLO":
	set(value):
		text = value
		_render_text()

func _render_text() -> void:
	var imgPath: String = ""
	for child in get_children():
		child.queue_free()
		
	for char in text.to_upper():
		if char == " ":
			var space = Control.new()
			space.custom_minimum_size.x = 3
			add_child(space)
			continue
		var asciiCode = char.unicode_at(0)
		if asciiCode >= 65 and asciiCode <= 90:
			var imgNumber = asciiCode - 64
			imgPath = lettersFolder.path_join(str(imgNumber) + ".png")
		elif char == '.': 
			imgPath = lettersFolder.path_join("48.png")
		elif char == '!':
			imgPath = lettersFolder.path_join("46.png")
			
		if ResourceLoader.exists(imgPath):
			var textureRect = TextureRect.new()
			textureRect.texture = load(imgPath)
			textureRect.stretch_mode = TextureRect.STRETCH_KEEP
			add_child(textureRect)
			
