tool

extends StaticBody2D

export(int) var frame = 0 setget _set_frame

func _set_frame(new_frame: int):
	frame = new_frame
	$Sprite2D.frame = frame
