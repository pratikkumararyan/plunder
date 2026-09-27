@tool
extends HFlowContainer

@export_dir var lettersFolder: String = "res://Assets/Wood and Paper UI/Sprites/Big Text/"

@export_multiline var text: String = "HELLO":
	set(value):
		text = value
		_render_text()

func _ready() -> void:
	_render_text()

func _render_text() -> void:
	for child in get_children():
		child.queue_free()

	var addedCount: int = 0

	for char in text.to_upper():
		if char == " ":
			var space = Control.new()
			space.custom_minimum_size.x = 3
			add_child(space)
			continue

		var imgPath: String = _get_image_path(char)

		#if imgPath == "":
			#print("No mapping for character: '", char, "'")
			#continue
#
		#print("Trying: ", imgPath)
		#print("Exists: ", ResourceLoader.exists(imgPath))

		var texture = load(imgPath)

		if texture == null:
			#print("LOAD FAILED: ", imgPath)
			continue

		var textureRect = TextureRect.new()
		textureRect.texture = texture
		textureRect.stretch_mode = TextureRect.STRETCH_KEEP
		add_child(textureRect)
		addedCount += 1


	#print("Rendered ", addedCount, " character(s) out of ", text.length())

func _get_image_path(char: String) -> String:
	var asciiCode = char.unicode_at(0)

	if asciiCode >= 65 and asciiCode <= 90:
		var imgNumber = asciiCode - 64
		return lettersFolder.path_join(str(imgNumber) + ".png")
	elif char == '.':
		return lettersFolder.path_join("48.png")
	elif char == '!':
		return lettersFolder.path_join("46.png")
	elif char == '0':
		return lettersFolder.path_join("36.png")
	elif char.is_valid_int():
		return lettersFolder.path_join(str(int(char) + 26) + ".png")
	else:
		return ""


func _on_button_2_pressed() -> void:
	pass # Replace with function body.
