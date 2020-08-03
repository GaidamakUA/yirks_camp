tool

extends BaseInteractiveObject

signal switch_flipped(is_on)

export(bool) var is_on := false setget _set_is_enabled

onready var animation_player = $AnimationPlayer
onready var handle = $Handle

func _ready():
	_set_is_enabled(is_on)

func _interact():
	if(is_on):
		animation_player.play_backwards("turn_on")
	else:
		animation_player.play("turn_on")

func _set_is_enabled(new_value: bool):
	is_on = new_value
	# Hardcode :(
	var off_position := Vector2(0, -33)
	var on_position := Vector2(0, -19)
	if not is_initialized:
		yield(self ,"ready")
	if(is_on):
		yeerk_palm.position = on_position
		handle.position = on_position
	else:
		yeerk_palm.position = off_position
		handle.position = off_position
	emit_signal("switch_flipped", is_on)
