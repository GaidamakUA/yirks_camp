extends Node2D

const Pioneress = preload("res://character/pioneeres/Pioneeres.tscn")
const Blood = preload("res://objects/Blood.tscn")
const Cedaver = preload("res://objects/Cedaver.tscn")

onready var decorations = $Decorations
onready var decals = $Decals
onready var actors = $Objects
onready var death_animation = $DeathAnimation

func _on_Pioneeres_dying(place_of_death):
	death_animation._on_Pioneeres_dying(place_of_death)
	
	var blood = Blood.instance()
	blood.position = place_of_death
	decals.add_child(blood)
	
	var cedaver = Cedaver.instance()
	cedaver.position = place_of_death
	decorations.add_child(cedaver)
