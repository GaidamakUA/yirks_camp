extends YSort

class_name GatheringPlace

onready var rest_places = $RestPlaces.get_children()

func get_free_place() -> Position2D:
	for place in rest_places:
		if not place.is_occupied:
			return place
	print("Should not happen")
	return rest_places[0]

func has_room() -> bool:
	for place in rest_places:
		if not place.is_occupied():
			return true
	return false
