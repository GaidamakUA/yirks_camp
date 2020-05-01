extends Node2D

const Pioneress = preload("res://character/pioneeres/Pioneeres.tscn")

onready var spawn_area: ReferenceRect = $SpawnArea
onready var actors = $Actors
onready var deat_animation = $DeathAnimation

func _ready():
	_spawn_pioneress()
	_spawn_pioneress()
	_spawn_pioneress()
	_spawn_pioneress()
	_spawn_pioneress()

func _spawn_pioneress():
	print("_spawn_pioneress")
	var pioneress = Pioneress.instance()
	
	var rand_x = randf()
	var rand_y = randf()
	var spawn_position = spawn_area.rect_size
	spawn_position.x = spawn_position.x * rand_x
	spawn_position.y = spawn_position.y * rand_y
	spawn_position += spawn_area.rect_position
	pioneress.position = spawn_position
	
	pioneress.connect("dying", deat_animation, "_on_Pioneeres_dying")
	
	actors.add_child(pioneress)

func _on_AnimationPlayer_animation_finished(anim_name):
	_spawn_pioneress()
