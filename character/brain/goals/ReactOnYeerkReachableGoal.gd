extends BaseGoal

class_name ReactOnYeerkReachableGoal

func calculate_weight() -> int:
	var hit_reach_sensor: Area2D = brain.hit_reach_sensor
	var direct_sight: RayCast2D = brain.direct_sight_sensor
	var colliding_areas = hit_reach_sensor.get_overlapping_areas()
	for area in colliding_areas:
		var parent = area.get_parent()
		if parent is Player:
			var player_position = parent.position
			direct_sight.look_at(player_position)
			direct_sight.force_raycast_update()
			if direct_sight.get_collider() is Player:
				return priority
	return 0

func _to_string() -> String:
	return "ReactOnYeerkGoal"
