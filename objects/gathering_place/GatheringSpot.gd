extends Position2D

var is_occupied := false

func _on_Area2D_body_entered(body):
	is_occupied = true

func _on_Area2D_body_exited(body):
	is_occupied = false
