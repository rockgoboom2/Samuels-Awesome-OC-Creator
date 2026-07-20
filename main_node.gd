extends Node2D
@onready var sprite_2d_color: Sprite2D = %Sprite2DColor
@onready var hat: Sprite2D = $Sprite2D/Hat

@onready var color_picker: ColorPicker = %ColorPicker




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sprite_2d_color.set_modulate(color_picker.color)


func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		hat.show()
	else:
		hat.hide()
