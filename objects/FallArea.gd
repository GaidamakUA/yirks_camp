extends Area2D

func _on_FallArea_area_entered(area):
	var player = area.get_parent()
	player.fall_down()
