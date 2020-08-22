extends Node2D

signal yeerk_appeared

func _ready():
	$AnimationPlayer.play("yeerks_appearance")

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
	emit_signal("yeerk_appeared")
