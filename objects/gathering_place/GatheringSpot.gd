extends Position2D

class_name GatheringSpot

var is_occupied := false

func _on_Area2D_body_entered(body):
	is_occupied = true

func _on_Area2D_body_exited(body):
	is_occupied = false

func is_occupied() -> bool:
	return not $Area2D.get_overlapping_areas().empty()

func get_gathering_place() -> GatheringPlace:
	return get_parent().get_parent() as GatheringPlace
