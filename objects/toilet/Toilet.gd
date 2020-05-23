extends Node2D

onready var door = $Door

func _interact():
	if door.is_open():
		door.close()
	else:
		door.open()

func _on_yeerk_entered(area):
	door.show_palm()

func _on_yeerk_exited(area):
	door.hide_palm()
