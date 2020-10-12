extends Node2D

signal arrived
signal direction_update(direction)

export(float, 10, 200) var raycast_length := 100

onready var raycast: RayCast2D = $NavigationRaycast

onready var direction_indicator: RayCast2D = $RayCast2D
onready var target = $Target

var _destination: Vector2 = Vector2.INF
var _preferred_direction = PI / 2
var arrival_threshhold := 10.0

func _ready():
	_randomize_preferred_direction()
	var actor = get_parent().get_parent()
	self.connect("direction_update", actor, "_on_direction")

func set_destination(destination: Vector2, desired_distance := 0.0):
	_destination = destination
	if desired_distance == 0.0:
		arrival_threshhold = 10
	else:
		arrival_threshhold = desired_distance

func drop():
	_destination = global_position

func _physics_process(_delta):
	if not _is_active():
		return
	elif _is_arrived():
		_destination = Vector2.INF
		emit_signal("direction_update", Vector2.ZERO)
		emit_signal("arrived")
	else:
		target.global_position = _destination
		var direction = global_position.direction_to(_destination)
		raycast.look_at(_destination)
		var distance_to_collision = raycast.get_collision_point().distance_to(global_position)
		if raycast.is_colliding() && _remaining_distance() > distance_to_collision:
			var displacement = raycast.get_collision_normal().rotated(_preferred_direction)
			var displacement_scale = (raycast_length - distance_to_collision) / raycast_length
			direction = direction * displacement_scale + displacement * displacement_scale
		direction_indicator.look_at(global_position + direction)
		
		emit_signal("direction_update", direction) 

func _is_active() -> bool:
	return _destination != Vector2.INF

func _is_arrived() -> bool:
	return _remaining_distance() < arrival_threshhold

func _remaining_distance() -> float:
	return _destination.distance_to(global_position)

func _randomize_preferred_direction():
	_preferred_direction = sign(randf() - 0.3) * PI / 2
