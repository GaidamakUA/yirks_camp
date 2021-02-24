extends BaseLevel

onready var yeerk = $Objects/Player

var pioneeres_count = 4
var is_ready := false

func _ready():
	yeerk.hide()
	yeerk.set_process(false)
	is_ready = true

func _on_YeerksAppearance_yeerk_appeared():
	yeerk.show()
	yeerk.set_process(true)

func _on_Pioneeres_dead(place_of_death):
	pioneeres_count -= 1

func load_data(game_data: Dictionary):
	.load_data(game_data)
	if not is_ready:
		yield(self, "ready")
	$Objects/YeerksAppearance.hide()
	_on_YeerksAppearance_yeerk_appeared()

func _on_Level2Teleport_area_activated():
	get_tree().change_scene("res://levels/Level2.Mine.tscn")
