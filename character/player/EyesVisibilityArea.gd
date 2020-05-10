extends Area2D

onready var eyes = $Eyes

func _ready():
	eyes.hide()

func _on_EyesVisibilityArea_body_entered(body):
	print("entered")
	eyes.show()

func _on_EyesVisibilityArea_body_exited(body):
	print("exited")
	eyes.hide()
