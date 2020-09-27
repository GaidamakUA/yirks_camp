extends Control

onready var texture_progress = $TextureProgress

func _on_energy_changed(value):
	texture_progress.value = value
