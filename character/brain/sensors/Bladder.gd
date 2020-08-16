extends Node2D

class_name Bladder

export(float, 0, 0.5) var pee_level_step := 0.1

onready var timer = $Timer

var pee_level := 0.0

func increase_pee_level():
	pee_level += pee_level_step

func reset_pee_level():
	pee_level = 0.0
