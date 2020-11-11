extends Node2D

class_name Bladder

export(float, 0, 1) var pee_tick := 0.1
export(int, 100, 500) var max_pee = 100

var pee_level := 0

func _ready():
	var timer = Timer.new()
	timer.wait_time = pee_tick
	timer.connect("timeout", self, "_increase_pee_level")
	add_child(timer)
	timer.start()

func _increase_pee_level():
	pee_level += 1
	var pee_percent = pee_level * 1.0 / max_pee
	if $Polygon2D:
		$Polygon2D.scale.x = pee_percent

func is_full() -> bool:
	return pee_level >= max_pee

func reset_pee_level():
	pee_level = 0
