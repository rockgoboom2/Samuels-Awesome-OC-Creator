extends LineEdit

@onready var is_html: bool = OS.has_feature("web")

func _input(event: InputEvent) -> void:
	if is_html and (event is InputEventMouseButton or event is InputEventScreenTouch):
		if event.is_pressed():
			accept_event()
			
			var new_text = JavaScriptBridge.eval('prompt("Enter text:", "%s");' % text)
			
			if new_text != null:
				text = new_text.substr(0, max_length)
				text_submitted.emit(text) # Godot 4 uses the new signal syntax
