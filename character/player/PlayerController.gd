extends Node

signal direction(direction, delta)

var dash_distance: float = 200
export(float) var dash_time := 0.7

const Afterimage = preload("res://character/player/PlayerAfterimage.tscn")

onready var tween = $DashTween
onready var character = get_parent()
onready var area = get_parent().find_node("Area2D")
onready var spawn = $Spawn

func _physics_process(delta):
	var bodies = area.get_overlapping_bodies()
	var has_solid = false
	for body in bodies:
		if body.get_collision_layer_bit(1) || body.get_collision_layer_bit(2):
			has_solid = true
	
	if tween.is_active() && has_solid:
		tween.seek(tween.tell() - 0.02)
		tween.remove_all()
		spawn.stop()

func _process(delta):
	if tween.is_active():
		return
	if Input.is_action_just_pressed("dash"):
		_play_dash()
		return

	var new_direction = Vector2.ZERO

	new_direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	new_direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	emit_signal("direction", new_direction)

func _play_dash():
	print(character.last_direction)
	character.state_machine.travel("Dash")
	var start: Vector2 = character.position
	var finish: Vector2 = character.position + dash_distance * character.last_direction
	tween.interpolate_property(character, "position", start, finish, dash_time,  Tween.TRANS_BACK,  Tween.EASE_IN)
	tween.start()
	spawn.start()
	print("dashing")

func _on_Spawn_timeout():
	var afterimage: Sprite = Afterimage.instance()
	var sprite = character.find_node("Sprite")
	afterimage.global_position = sprite.global_position
	afterimage.frame = sprite.frame
	var world = character.get_parent()
	world.add_child(afterimage)


func _on_DashTween_tween_all_completed():
	spawn.stop()

func _on_Area2D_body_entered(body):
	if body.get_collision_layer_bit(1):
		body.die()
		print("colliding with pioneress")

func _on_Player_colliding(collision):
	_on_Area2D_body_entered(collision.collider)
