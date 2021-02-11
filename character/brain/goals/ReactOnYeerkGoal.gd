extends BaseGoal

class_name ReactOnYeerkGoal

func calculate_weight() -> int:
	var sight_cone: Area2D = brain.sight_cone
	var direct_sight: RayCast2D = brain.direct_sight_sensor
	var colliding_bodies = sight_cone.get_overlapping_bodies()
	for body in colliding_bodies:
		if body is Player:
			var player_position = body.position
			direct_sight.look_at(player_position)
			direct_sight.force_raycast_update()
			if direct_sight.get_collider() is Player:
				return priority
	return 0

func _to_string() -> String:
	return "ReactOnYeerkGoal"
