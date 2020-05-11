extends Area2D

onready var eyes = $Eyes

func _ready():
	eyes.hide()

func _on_EyesVisibilityArea_body_entered(_body):
	print("entered")
	eyes.show()

func _on_EyesVisibilityArea_body_exited(_body):
	print("exited")
	eyes.hide()
