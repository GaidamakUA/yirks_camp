extends Area2D

func _process(delta):
	if get_parent().actor.last_direction:
		look_at(get_parent().actor.last_direction + global_position)
