extends KinematicBody2D

signal dying(place_of_death)

export(int) var acceleration := 400
export(int) var max_speed := 80
export(int) var friction := 400

onready var animation_tree = $AnimationTree
onready var state_machine = animation_tree["parameters/playback"]
onready var emotion_bubble = $EmotionBubble

var _direction := Vector2.ZERO
var last_direction := Vector2.UP
var velocity := Vector2.ZERO

func _ready():
	animation_tree.active = true
	emotion_bubble.hide()

func _on_direction(new_direction: Vector2):
	_direction = new_direction.normalized()
	if new_direction.is_equal_approx(Vector2.ZERO):
		state_machine.travel("Resting")
		pass
	else:
		last_direction = _direction
		state_machine.travel("Run")
		animation_tree.set("parameters/Resting/blend_position", _direction)
		animation_tree.set("parameters/Run/blend_position", _direction)
		animation_tree.set("parameters/Dash/blend_position", _direction)

func _physics_process(delta):
	if _direction.is_equal_approx(Vector2.ZERO):
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	else:
		velocity = velocity.move_toward(max_speed * _direction, acceleration * delta)
	velocity = move_and_slide(velocity)

func die():
	emit_signal("dying", position)
	queue_free()
