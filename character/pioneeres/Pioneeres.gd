extends "../Character.gd"

class_name Pioneeres

const Cedaver = preload("res://objects/cedaver/Cedaver.tscn")

onready var brain = $Brain

func _ready():
	add_to_group("Persist")

func _on_HurtBox_area_entered(_area):
	die()

func die():
	if brain:
		brain.die()
	var animation := ""
	match randi() % 3:
		0: animation = "death_0"
		1: animation = "death_1"
		2: animation = "death_2"
	yield(play_extra_animation(animation), "completed")

	var cedaver = Cedaver.instance()
	cedaver.position = position + Vector2(0, -16)
	get_parent().add_child(cedaver)

	queue_free()

func _on_Hitbox_area_entered(area):
	area.get_parent().take_damage_from_pioneeres()

func save() -> Dictionary:
	var dict := .save()
	dict["brain"] = brain.save()
	return dict
