tool

extends YSort

signal engine_failed

export(bool) var front_open := false setget _set_front_opened, _get_front_opened
export(bool) var back_open := false setget _set_back_opened, _get_back_opened

onready var front_door = $DoorFront
onready var back_door = $DoorBack

var is_initialized = false

func _ready():
	is_initialized = true

func _set_front_opened(new_open: bool):
	if not is_initialized:
		yield(self, "ready")
	front_door.open = new_open
	
func _get_front_opened() -> bool:
	return front_door.open

func _set_back_opened(new_open: bool):
	if not is_initialized:
		yield(self, "ready")
	back_door.open = new_open
	
func _get_back_opened() -> bool:
	return back_door.open

func _on_BusControlPanel_start_engine():
	emit_signal("engine_failed")
	$EngineFailedPlayer.play()
