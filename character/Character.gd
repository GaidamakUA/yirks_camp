extends KinematicBody2D

signal colliding(collision)
signal dying(place_of_death)

var DEFAULT_SPEED := 60
export(int) var character_speed := 60

onready var animation_tree = $AnimationTree
onready var state_machine = animation_tree["parameters/playback"]

var _direction := Vector2.ZERO
var last_direction = Direction.UP

func _ready():
	$Controller.connect("direction", self, "_on_direction")

func _on_direction(new_direction: Vector2):
	_direction = new_direction.clamped(1)
	if new_direction.is_equal_approx(Vector2.ZERO):
		state_machine.travel("Idle")
		pass
	else:
		last_direction = _direction
		state_machine.travel("Run")
		animation_tree.set("parameters/Idle/blend_position", _direction)
		animation_tree.set("parameters/Run/blend_position", _direction)
		animation_tree.set("parameters/Dash/blend_position", _direction)

func _process(delta):
	if _direction.is_equal_approx(Vector2.ZERO):
		return
	_move_to_direction(_direction * delta)

func _move_to_direction(direction: Vector2):
	var collision = move_and_collide(direction * character_speed)
	if collision:
		emit_signal("colliding", collision)

func die():
	emit_signal("dying", position)
	queue_free()

enum Direction {RIGHT, LEFT, UP, DOWN}
