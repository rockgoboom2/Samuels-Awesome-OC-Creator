extends Node2D
@onready var sprite_2d_color: Sprite2D = %Sprite2DColor
@onready var hat: Sprite2D = $Sprite2D/Hat
@onready var hat_back: Sprite2D = $Sprite2D/Hat/Hat_Back
@onready var texture_rect: TextureRect = $Sprite2D/Sprite2DColor/TextureRect

@onready var color_picker: ColorPicker = %ColorPicker
@onready var file_access_web = FileAccessWeb.new()


var hat_on = false

var body_color: Color = Color(0.63, 0.935, 0.28, 1.0)
var hat_color: Color = Color(0.545, 164.003, 190.588, 1.0)

var body_image:Image = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	file_access_web.loaded.connect(_on_file_loaded)
	
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
	
	hat.visible = toggled_on
	hat_on = toggled_on
	


func _on_color_picker_color_changed(color: Color) -> void:
	if hat_on == true:
		hat_color = color
	else:
		body_color = color


func _on_file_dialog_file_selected(path: String) -> void:
	pass
	#texture_rect.texture = load(path)
	





func _on_v_slider_value_changed(value: float) -> void:
	texture_rect.modulate.a = value


func _on_html_5_file_exchange_file_loaded(buffer: PackedByteArray, file_type: String, file_name: String) -> void:
	var image = Image.new()
	var error: Error
	match file_type:
		"image/png": error = image.load_png_from_buffer(buffer)
		"image/jpeg": error = image.load_jpg_from_buffer(buffer)
		"image/webp": error = image.load_webp_from_buffer(buffer)
		_:
			print("Non texture image format: ", file_type)
			return
	
	if error != OK:
		print("Failed to load image")
		return
		
	texture_rect.texture = ImageTexture.create_from_image(image)


func _on_upload_button_pressed() -> void:
	file_access_web.open()

func _load_image(image: Image, type: String, data: PackedByteArray) -> int:
	match type:
		"image/png":
			return image.load_png_from_buffer(data)
		"image/jpeg":
			return image.load_jpg_from_buffer(data)
		"image/webp":
			return image.load_webp_from_buffer(data)
		_:
			return Error.FAILED

func raw_draw(type: String, data: PackedByteArray) -> void:
	var image := Image.new()
	var error: int = _load_image(image, type, data)
	
	if not error:
		texture_rect.texture = _create_texture_from(image)
	else:
		push_error("Error %s id" % error)


func _create_texture_from(image: Image) -> ImageTexture:
	var texture = ImageTexture.new()
	texture.set_image(image)
	return texture


func _on_file_loaded(file_name: String, type: String, base64_data: String) -> void:
		var raw_data: PackedByteArray = Marshalls.base64_to_raw(base64_data)
		raw_draw(type, raw_data)
