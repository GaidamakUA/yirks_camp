extends BaseInteractiveObject

class_name Door

onready var animation_player = $AnimationPlayer
onready var collision_shape = $Collision/CollisionShape2D

func _ready():
	animation_player.current_animation = "open_door"
	animation_player.stop(true)

func _interact():
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
