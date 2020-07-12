extends Node2D

signal arrived

export(float, 0.1, 40) var arrival_threshhold := 10.0
export(float, 10, 200) var raycast_length := 100

onready var raycast: RayCast2D = $NavigationRaycast

onready var direction_indicator: RayCast2D = $RayCast2D
onready var target = $Target

var _destination: Vector2 = Vector2.INF
var _preferred_direction = PI / 2

func set_destination(destination: Vector2):
	_destination = destination

func get_direction() -> Vector2:
	if is_arrived():
		return Vector2.ZERO
	target.global_position = _destination
	var direction = global_position.direction_to(_destination)
	raycast.look_at(_destination)
	var distance_to_collision = raycast.get_collision_point().distance_to(global_position)
	if raycast.is_colliding() && _remaining_distance() > distance_to_collision:
		var displacement = raycast.get_collision_normal().rotated(_preferred_direction)
		var displacement_scale = (raycast_length - distance_to_collision) / raycast_length
		var displacement_scale_inv = 1 / displacement_scale
		direction = direction * displacement_scale + displacement * displacement_scale
	direction_indicator.look_at(global_position + direction)
	
	return direction

func is_arrived() -> bool:
	if _remaining_distance() < arrival_threshhold:
		emit_signal("arrived")
		_destination = Vector2.INF
	return _destination == Vector2.INF

func _remaining_distance() -> float:
	return _destination.distance_to(global_position)

func _on_change_direction():
	_preferred_direction = sign(randf() - 0.3) * PI / 2
