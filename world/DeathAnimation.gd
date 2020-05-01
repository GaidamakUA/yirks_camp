extends Sprite

onready var aniation_player = $AnimationPlayer

func _ready():
	hide()

func _on_Pioneeres_dying(place_of_death):
	global_position = place_of_death
	show()
	aniation_player.play("death1")
	yield(aniation_player, "animation_finished")
	hide()
