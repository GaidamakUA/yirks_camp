extends "BaseLevel.gd"

func _ready():
	yeerk.hide()
	yeerk.set_process(false)

func _on_YeerksAppearance_yeerk_appeared():
	yeerk.show()
	yeerk.set_process(true)
