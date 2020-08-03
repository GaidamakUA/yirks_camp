tool

extends Node2D

class_name BaseInteractiveObject

onready var yeerk_palm = $YeerkPalm
var is_initialized = false

func _ready():
	is_initialized = true

func _interact():
	# To be overriden by children
	pass

func show_palm():
	yeerk_palm.show()

func hide_palm():
	yeerk_palm.hide()
