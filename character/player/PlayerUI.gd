extends Control

onready var texture_progress = $TextureProgress

var is_ready = false

func _ready():
	is_ready = true

func _on_energy_changed(max_value, value):
	if not is_ready:
		yield(self, "ready")
	texture_progress.max_value = max_value
	texture_progress.value = value
