extends Area2D

signal interact
signal player_entered
signal player_exited
signal finished_interaction

func interact():
	emit_signal("interact")

func player_entered():
	emit_signal("player_entered")

func player_exited():
	emit_signal("player_exited")

func _on_AnimationPlayer_animation_finished(_anim_name):
	emit_signal("finished_interaction")
