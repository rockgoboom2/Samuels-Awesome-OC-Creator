extends LineEdit

@onready var is_html := OS.has_feature("web")

func _gui_input(event: InputEvent) -> void:
	if !is_html:
		return

	if event is InputEventScreenTouch and event.pressed:
		accept_event()

		var new_text = JavaScriptBridge.eval(
			'prompt("Enter text:", "%s")' % text
		)

		if new_text != null:
			text = str(new_text)
			if max_length > 0:
				text = text.substr(0, max_length)

			text_changed.emit(text)
			text_submitted.emit(text)
