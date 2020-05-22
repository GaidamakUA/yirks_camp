extends Node2D

onready var door = $Door

func _ready():
	_on_door_state_changed("")

func _on_door_state_changed(_animaction):
	if door.is_open():
		door.close()
	else:
		door.open()
