extends Node2D

signal beeping

func _on_BeeperButton_beeping():
	emit_signal("beeping")
