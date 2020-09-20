extends Area2D

signal finished_interaction

func interact():
	get_parent()._interact()

func player_entered():
	get_parent().player_entered()

func player_exited():
	get_parent().player_exited()

func _on_AnimationPlayer_animation_finished(_anim_name):
	emit_signal("finished_interaction")
