extends Precondition

class_name CanHitYeerk

func _is_valid(brain) -> bool:
	var hit_reach_sensor: Area2D = brain.hit_reach_sensor
	var colliding_areas = hit_reach_sensor.get_overlapping_areas()
	for area in colliding_areas:
		var parent = area.get_parent()
		if parent is Player:
			return true
	return false
