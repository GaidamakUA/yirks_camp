extends VBoxContainer

class_name Menu

export(bool) var shown = true setget _on_shown_changed

onready var _tween = $Tween
 
var _shown_position := Vector2.ZERO
var _hidden_position := Vector2.ZERO
var _animation_duration := 1.0

func _ready():
	var distance = rect_size.x + 60
	if shown:
		_shown_position = rect_position
		_hidden_position = rect_position - Vector2(distance, 0)
	else:
		_shown_position = rect_position + Vector2(distance, 0)
		_hidden_position = rect_position
	
func _on_shown_changed(new_shown):
	shown = new_shown

func menu_show():
	_set_shown(true)

func menu_hide():
	_set_shown(false)

func _set_shown(is_shown: bool):
	if is_shown == shown:
		return
	shown = is_shown
	if shown:
		show()
		_tween.interpolate_property(self, "rect_position", _hidden_position, _shown_position, _animation_duration)
		_tween.start()
	else:
		_tween.interpolate_property(self, "rect_position", _shown_position, _hidden_position, _animation_duration)
		_tween.start()
		yield(_tween, "tween_completed")
		hide()
