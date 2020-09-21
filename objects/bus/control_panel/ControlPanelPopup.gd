extends Node2D

signal beeping
signal back_door_new_state(new_state)
signal front_door_new_state(new_state)
signal start_engine

onready var powered: bool = $PowerButton.is_on
onready var engine_on: bool = $EngineSwitch.is_on
onready var start_from_cockpit: bool = $StarterPicker.is_on

func _on_BeeperButton_beeping():
	emit_signal("beeping")

func _on_BackDoorsSwitch_changed_state(new_state: bool):
	if powered:
		emit_signal("back_door_new_state", new_state)

func _on_FronDoorsSwitch_changed_state(new_state: bool):
	if powered:
		emit_signal("front_door_new_state", new_state)

func _on_PowerButton_changed_state(new_state: bool):
	powered = new_state

func _on_EngineSwitch_changed_state(new_state: bool):
	engine_on = new_state

func _on_StarterPicker_changed_state(new_state: bool):
	start_from_cockpit = new_state


func _on_StartButton_pressed():
	if not powered:
		return
	if not engine_on:
		return
	if not start_from_cockpit:
		return
	emit_signal("start_engine")
