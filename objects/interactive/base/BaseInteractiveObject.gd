extends Node2D

onready var yeerk_palm = $YeerkPalm

func _interact():
	# To be overriden by children
	pass

func show_palm():
	yeerk_palm.show()

func hide_palm():
	yeerk_palm.hide()
