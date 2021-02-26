extends Node

var position: Vector2
var barrel_picked := false
# Test value
var energy := 500
var from_level2 := false

func reset():
	barrel_picked = false
	from_level2 = false
