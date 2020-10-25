extends "../Character.gd"

class_name Pioneeres

func _ready():
	var scene_root = get_tree().current_scene
	self.connect("dying", scene_root, "_on_Pioneeres_dying")

func _on_HurtBox_area_entered(_area):
	die()

func _on_Hitbox_area_entered(area):
	area.get_parent().take_damage_from_pioneeres()
