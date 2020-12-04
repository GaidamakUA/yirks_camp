extends Node2D

onready var yeerk = $Objects/Player

var pioneeres_count = 4

func _ready():
	yeerk.hide()
	yeerk.set_process(false)

func _on_YeerksAppearance_yeerk_appeared():
	yeerk.show()
	yeerk.set_process(true)

func _on_Pioneeres_dead(place_of_death):
	pioneeres_count -= 1
	if pioneeres_count == 0:
		$CanvasLayer/PlayerUI/VictoryPlaceholder.show()
		var timer = Timer.new()
		timer.wait_time = 4
		add_child(timer)
		timer.start()
		yield(timer, "timeout")
		get_tree().change_scene("res://ui/MainMenu.tscn")


func _on_Player_dying(place_of_death):
	$CanvasLayer/PlayerUI/LossPlaceholder.show()
	var timer = Timer.new()
	timer.wait_time = 4
	add_child(timer)
	timer.start()
	yield(timer, "timeout")
	get_tree().change_scene("res://ui/MainMenu.tscn")
