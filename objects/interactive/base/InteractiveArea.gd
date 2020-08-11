extends Area2D

signal finished_interaction

func interact():
	get_parent()._interact()

func show_palm():
	get_parent().show_palm()

func hide_palm():
	get_parent().hide_palm()

func _on_AnimationPlayer_animation_finished(_anim_name):
	emit_signal("finished_interaction")
