extends "../Character.gd"

func _ready():
	var scene_root = get_tree().current_scene
	self.connect("dying", scene_root, "_on_Pioneeres_dying")
	if $Brain:
		$Brain.start()

func _on_HurtBox_area_entered(_area):
	die()
