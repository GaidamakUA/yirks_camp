extends Node

signal direction

var directions = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT, Vector2.ZERO]
var walk_time = -1
var direction = Vector2.ZERO

func _process(delta):
	if walk_time < 0:
		walk_time = rand_range(1, 5)
		var random_index = randi() % 5
		direction = directions[random_index]
	walk_time -= delta
	emit_signal("direction", direction)

func _on_Pioneeres_colliding(collision):
	walk_time = -1
