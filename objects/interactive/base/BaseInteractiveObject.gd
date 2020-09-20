tool

extends Node2D

class_name BaseInteractiveObject

onready var yeerk_palm = $YeerkPalm
var is_initialized = false

func _ready():
	is_initialized = true
	yeerk_palm.hide()

func _interact():
	# To be overriden by children
	pass

func player_entered():
	yeerk_palm.show()
	_player_entered()

func player_exited():
	yeerk_palm.hide()
	_player_exited()

func _player_entered():
	# To be overriden by children
	pass

func _player_exited():
	# To be overriden by children
	pass
