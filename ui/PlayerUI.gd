extends Control

onready var texture_progress = $TextureProgress

const yeerks_speech_position := Vector2(984, 559)

var is_ready = false
var yeerks_speech_scene = preload("res://ui/YeerksSpeach.tscn")

func _ready():
	is_ready = true

func _on_energy_changed(max_value, value):
	if not is_ready:
		yield(self, "ready")
	texture_progress.max_value = max_value
	texture_progress.value = value

func post_yeerks_replica(text: String):
	var yeerks_speech = yeerks_speech_scene.instance()
	add_child(yeerks_speech)
	yeerks_speech.rect_position = yeerks_speech_position
	yeerks_speech.post_text(text)
	yield(yeerks_speech, "finished_replica")
	yield(get_tree().create_timer(1), "timeout")
	yeerks_speech.queue_free()
