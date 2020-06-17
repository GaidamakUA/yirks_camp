extends Node2D

const Pioneress = preload("res://character/pioneeres/Pioneeres.tscn")
const Cedaver = preload("res://objects/cedaver/Cedaver.tscn")

onready var actors = $Objects
onready var death_animation = $DeathAnimation
onready var spawn_point = $Spawn
onready var yeerk = $Objects/Character

func _ready():
	randomize()

func _on_Pioneeres_dying(place_of_death):
	death_animation._on_Pioneeres_dying(place_of_death)
	
	var cedaver = Cedaver.instance()
	cedaver.position = place_of_death + Vector2(0, -16)
	actors.add_child(cedaver)
	
	var pioneress = Pioneress.instance()
	pioneress.global_position = spawn_point.global_position
	actors.add_child(pioneress)
