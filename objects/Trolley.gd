extends StaticBody2D

onready var animation_player = $AnimationPlayer

func _on_character_entered(area):
	animation_player.play("fall")
