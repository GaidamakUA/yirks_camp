extends KinematicBody2D

signal colliding(collision)

var DEFAULT_SPEED := 60
export(int) var character_speed := 60

onready var animationPlayer = $AnimationPlayer

var _direction := Vector2.ZERO
var looking_direction = Direction.UP

func _ready():
	$Controller.connect("direction", self, "_on_direction")

func _on_direction(new_direction: Vector2):
	if new_direction.is_equal_approx(Vector2.ZERO):
		_set_resting()
	else:
		_move_to_direction(new_direction)
		if not new_direction.is_equal_approx(_direction):
			_direction = new_direction
		_play_animation_if_necessary()

func _play_animation_if_necessary():
	var animation = ""
	match get_direction_looking():
		Direction.RIGHT:
			animation = "run_right"
		Direction.LEFT:
			animation = "run_left"
		Direction.DOWN:
			animation = "run_down"
		Direction.UP:
			animation = "run_up"
	if animationPlayer.is_playing() && animationPlayer.current_animation == animation:
		return
	animationPlayer.playback_speed = float(character_speed)/DEFAULT_SPEED
	animationPlayer.play(animation)

func _set_resting():
	match get_direction_looking():
		Direction.RIGHT:
			animationPlayer.play("resting_pose_right")
		Direction.LEFT:
			animationPlayer.play("resting_pose_left")
		Direction.DOWN:
			animationPlayer.play("resting_pose_down")
		Direction.UP:
			animationPlayer.play("resting_pose_up")

func get_direction_looking() -> int:
	if abs(_direction.x) > abs(_direction.y):
		if _direction.x > 0:
			return Direction.RIGHT
		else:
			return Direction.LEFT
	else:
		if _direction.y > 0:
			return Direction.DOWN
		else:
			return Direction.UP

func _move_to_direction(direction: Vector2):
	var collision = move_and_collide(direction * character_speed)
	if collision:
		emit_signal("colliding", collision)

enum Direction {RIGHT, LEFT, UP, DOWN}
