extends Node2D
@onready var sprite_2d_color: Sprite2D = %Sprite2DColor
@onready var hat: Sprite2D = $Sprite2D/Hat
@onready var hat_back: Sprite2D = $Sprite2D/Hat/Hat_Back

@onready var color_picker: ColorPicker = %ColorPicker
var hat_on = false

var body_color: Color = Color(0.63, 0.935, 0.28, 1.0)
var hat_color: Color = Color(0.545, 164.003, 190.588, 1.0)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d_color.set_modulate(body_color)
	hat_back.set_modulate(hat_color)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if hat_on == false:
		color_picker.color = body_color
		sprite_2d_color.set_modulate(color_picker.color)
	else:
		color_picker.color = hat_color
		hat_back.set_modulate(color_picker.color)

func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		hat_on = true
		hat.show()
	else:
		hat_on = false
		hat.hide()


func _on_color_picker_color_changed(color: Color) -> void:
	if hat_on == true:
		hat_color = color
	else:
		body_color = color
