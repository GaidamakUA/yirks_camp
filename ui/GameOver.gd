extends Control

func _ready():
	$AnimationPlayer.play("appearance")

func go_to_main_menu():
	get_tree().change_scene("res://ui/MainMenu.tscn")
