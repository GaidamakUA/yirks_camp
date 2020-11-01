extends Node2D

const Cedaver = preload("res://objects/cedaver/Cedaver.tscn")

onready var actors = $Objects
onready var death_animation = $DeathAnimation

var death_cinematics = [
	preload("res://assets/dath_video/pioneeres_death_0.png"),
	preload("res://assets/dath_video/pioneeres_death_1.png"),
	preload("res://assets/dath_video/pioneeres_death_2.png")
]

func _ready():
	randomize()

func _on_Pioneeres_dying(place_of_death):
	var index = randi() % death_cinematics.size()
	death_animation.texture = death_cinematics[index]
	death_animation._on_Pioneeres_dying(place_of_death)
	
	var cedaver = Cedaver.instance()
	cedaver.position = place_of_death + Vector2(0, -16)
	actors.call_deferred("add_child", cedaver)
