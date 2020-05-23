extends Node2D

onready var door = $Door

func _interact():
	if door.is_open():
		door.close()
	else:
		door.open()
