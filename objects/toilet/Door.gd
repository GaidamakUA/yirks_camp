extends StaticBody2D

onready var animation_player = $AnimationPlayer
onready var collision_shape = $CollisionShape2D

func open():
	animation_player.play("Open")

func close():
	animation_player.play_backwards("Open")

func is_open() -> bool:
	return collision_shape.disabled
