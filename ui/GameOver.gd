extends Control

func _ready():
	$AnimationPlayer.play("appearance")

func _input(event):
	if event is InputEventKey:
		go_to_main_menu()
	print(event)

func go_to_main_menu():
	get_tree().change_scene("res://ui/MainMenu.tscn")
