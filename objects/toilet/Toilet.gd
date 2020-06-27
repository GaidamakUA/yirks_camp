extends Node2D

onready var door = $Door

func _interact():
	if door.is_open():
		door.close()
	else:
		door.open()

func show_palm():
	door.show_palm()

func hide_palm():
	door.hide_palm()
