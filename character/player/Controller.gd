extends Node

signal direction

var dash_distance: float = 200
export(float) var dash_time := 0.7

onready var animationPlayer = $DashAnimationPlayer
onready var tween = $DashTween
onready var character = get_parent()
onready var raycast = get_parent().find_node("RayCast2D")
onready var area = get_parent().find_node("Area2D")

func _ready():
	dash_distance = raycast.cast_to.length()

func _physics_process(delta):
	if tween.is_active() && not area.get_overlapping_bodies().empty():
		tween.seek(tween.tell() - 0.02)
		tween.remove_all()

func _process(delta):
	if tween.is_active():
		return
	if Input.is_action_just_pressed("dash"):
		_play_dash()
		return

	var new_direction = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		raycast.look_at(character.position + Vector2.UP)
		new_direction += Vector2.UP
	if Input.is_action_pressed("ui_down"):
		raycast.look_at(character.position + Vector2.DOWN)
		new_direction += Vector2.DOWN
	if Input.is_action_pressed("ui_left"):
		raycast.look_at(character.position + Vector2.LEFT)
		new_direction += Vector2.LEFT
	if Input.is_action_pressed("ui_right"):
		raycast.look_at(character.position + Vector2.RIGHT)
		new_direction += Vector2.RIGHT
	emit_signal("direction", new_direction * delta)

func _play_dash():
	var displacement := Vector2.ZERO
	match character.get_direction_looking():
		Direction.RIGHT:
			animationPlayer.play("dashing_right")
			displacement = Vector2.RIGHT * dash_distance
		Direction.LEFT:
			animationPlayer.play("dashing_left")
			displacement = Vector2.LEFT * dash_distance
		Direction.DOWN:
			animationPlayer.play("dashing_down")
			displacement = Vector2.DOWN * dash_distance
		Direction.UP:
			animationPlayer.play("dashing_up")
			displacement = Vector2.UP * dash_distance
	
	var start: Vector2 = character.position
	var finish: Vector2 = character.position + displacement
	tween.interpolate_property(character, "position", start, finish, dash_time,  Tween.TRANS_BACK,  Tween.EASE_IN)
	tween.start()
	
	print("dashing")

enum Direction {RIGHT, LEFT, UP, DOWN}
