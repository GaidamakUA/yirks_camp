extends Control

signal finished_replica

export(float, 0, 1) var delay_s := 0.1

var text: String
var index: = 0

onready var label = $Label
onready var timer = $Timer

func post_text(posted_text: String):
	text = posted_text
	$Timer.start(delay_s)

func show_next_character():
	index += 1
	if index <= text.length():
		label.text = text.substr(0, index)
		timer.start(delay_s)
	else:
		emit_signal("finished_replica")
