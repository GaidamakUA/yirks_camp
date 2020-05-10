extends KinematicBody2D

signal colliding(collision)
signal dying(place_of_death)

export(int) var acceleration := 10
export(int) var max_speed := 80
export(int) var friction := 10

onready var animation_tree = $AnimationTree
onready var state_machine = animation_tree["parameters/playback"]

var _direction := Vector2.ZERO
var last_direction = Direction.UP
var velocity = Vector2.ZERO

func _ready():
	$Controller.connect("direction", self, "_on_direction")

func _on_direction(new_direction: Vector2):
	_direction = new_direction.normalized()
	if new_direction.is_equal_approx(Vector2.ZERO):
		state_machine.travel("Idle")
		pass
	else:
		last_direction = _direction
		state_machine.travel("Run")
		animation_tree.set("parameters/Idle/blend_position", _direction)
		animation_tree.set("parameters/Run/blend_position", _direction)
		animation_tree.set("parameters/Dash/blend_position", _direction)

func _physics_process(delta):
	if _direction.is_equal_approx(Vector2.ZERO):
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	else:
		velocity += acceleration * _direction * delta
		velocity = velocity.clamped(max_speed * delta)
	_handle_movement()

func _handle_movement():
	var collision = move_and_collide(velocity)
	if collision:
		emit_signal("colliding", collision)
		velocity = Vector2.ZERO

func die():
	emit_signal("dying", position)
	queue_free()

enum Direction {RIGHT, LEFT, UP, DOWN}
