extends Control

var yeerk_displacement = Vector2(-32, 32)

onready var yeerk_face = $YeerkFace

func _input(event):
	if event is InputEventMouseMotion:
		var  mouse_position = event.position
		var viewport_size = get_viewport_rect().size
		var delta = mouse_position / viewport_size * yeerk_displacement
		yeerk_face.rect_position = yeerk_displacement - delta
