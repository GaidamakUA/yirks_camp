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
	if pioneeres_count == 0:
		$CanvasLayer/PlayerUI/VictoryPlaceholder.show()
		var timer = Timer.new()
		timer.wait_time = 4
		add_child(timer)
		timer.start()
		yield(timer, "timeout")
		get_tree().change_scene("res://ui/MainMenu.tscn")

func _on_Player_dying():
	$CanvasLayer/PlayerUI/LossPlaceholder.show()
	var timer = Timer.new()
	timer.wait_time = 4
	add_child(timer)
	timer.start()
	yield(timer, "timeout")
	get_tree().change_scene("res://ui/MainMenu.tscn")

func load_data(game_data: Dictionary):
	.load_data(game_data)
	if not is_ready:
		yield(self, "ready")
	$Objects/YeerksAppearance.hide()
	_on_YeerksAppearance_yeerk_appeared()
