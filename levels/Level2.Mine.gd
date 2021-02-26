extends BaseLevel

func _ready():
	$Objects/Player/Energy.value = PlayerInfoSingleton.energy
	$CanvasModulate.show()

func _on_TeleportToLevel1_area_activated():
	PlayerInfoSingleton.energy = $Objects/Player/Energy.value
	PlayerInfoSingleton.from_level2 = true
	get_tree().change_scene("res://levels/Level1.v2.tscn")
