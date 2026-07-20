extends TextureButton
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _pressed() -> void:
	audio_stream_player.play()
