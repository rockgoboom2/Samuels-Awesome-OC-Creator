extends CheckButton
@onready var button: Button = $Button
@onready var file_dialog: FileDialog = $FileDialog
@onready var main: Node2D = $"../../../.."
@onready var v_slider: VSlider = $VSlider

@onready var html_5_file_exchange: Html5FileExchange = $Html5FileExchange

func _ready() -> void:
	pass

func _on_toggled(toggled_on: bool) -> void:
	button.visible = toggled_on
	main.texture_rect.visible = toggled_on
	v_slider.visible = toggled_on

func _on_button_pressed() -> void:
	html_5_file_exchange.open_load_file_dialog()
	
