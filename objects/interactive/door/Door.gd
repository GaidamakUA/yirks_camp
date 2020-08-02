extends 'res://objects/interactive/base/BaseInteractiveObject.gd'

onready var animation_player = $AnimationPlayer
onready var collision_shape = $Collision/CollisionShape2D

func _interact():
	print("door interact")
	if is_open():
		close()
	else:
		open()

func open():
	animation_player.play("open_door")

func close():
	animation_player.play_backwards("open_door")

func is_open() -> bool:
	return collision_shape.disabled
