extends BaseLevel

onready var yeerk = $Objects/Player

var pioneeres_count = 4
var is_ready := false

func _ready():
	if PlayerInfoSingleton.from_level2:
		_on_YeerksAppearance_yeerk_appeared()
		yeerk.position = $Objects/StaticObjects/Level2Teleport.position
		$Objects/Player/Energy.value = PlayerInfoSingleton.energy
	else:
		yeerk.hide()
		yeerk.set_process(false)
		PlayerInfoSingleton.energy = $Objects/Player/Energy.value
	is_ready = true

func _on_YeerksAppearance_yeerk_appeared():
	yeerk.show()
	yeerk.set_process(true)

func _on_Pioneeres_dead(place_of_death):
	pioneeres_count -= 1

func load_data(game_data: Dictionary):
	$Objects/YeerksAppearance.hide()
	_on_YeerksAppearance_yeerk_appeared()
	.load_data(game_data)
	if not is_ready:
		yield(self, "ready")

func _on_Level2Teleport_area_activated():
	get_tree().change_scene("res://levels/Level2.Mine.tscn")
	PlayerInfoSingleton.energy = $Objects/Player/Energy.value

func _on_Laz_engine_started():
	get_tree().change_scene("res://ui/SuccesScene.tscn")
