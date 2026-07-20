extends CheckButton
@onready var control: Control = $"../Control"




func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		control.hide()
	else:
		control.show()
		
		
