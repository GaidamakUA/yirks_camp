extends VBoxContainer

export(bool) var shown = true setget _on_shown_changed

onready var _tween = $Tween

var _shown_position := Vector2.ZERO
var _hidden_position := Vector2.RIGHT * 14 * 16
var _animation_duration := 1.0

func _ready():
	if shown:
		_shown_position = rect_position
		_hidden_position = rect_position + Vector2.RIGHT * 14 * 32
	else:
		_shown_position = rect_position - Vector2.RIGHT * 14 * 32
		_hidden_position = rect_position
	
func _on_shown_changed(new_shown):
	shown = new_shown

func set_shown(is_shown: bool):
	if is_shown == shown:
		return
	shown = is_shown
	if shown:
		_tween.interpolate_property(self, "rect_position", _hidden_position, _shown_position, _animation_duration)
	else:
		_tween.interpolate_property(self, "rect_position", _shown_position, _hidden_position, _animation_duration)
	_tween.start()
