extends "BaseLevel.gd"

onready var spawn_area: ReferenceRect = $SpawnArea

func _ready():
	pass
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
	
	pioneress.connect("dying", death_animation, "_on_Pioneeres_dying")
	pioneress.connect("dying", self, "_on_Pioneeres_dying")
	
	actors.add_child(pioneress)

func _on_AnimationPlayer_animation_finished(anim_name):
	_spawn_pioneress()

func _on_Pioneeres_dying(place_of_death):
	var blood = Blood.instance()
	blood.position = place_of_death
	decals.add_child(blood)
	
	var cedaver = Cedaver.instance()
	cedaver.position = place_of_death
	decorations.add_child(cedaver)
