extends Node2D

class_name Toilet

var occupant

func _on_OccupationArea_body_entered(body):
	occupant = body

func _on_OccupationArea_body_exited(_body):
	occupant = null

func is_free() -> bool:
	print("Toilet occupant ", occupant)
	return occupant == null
