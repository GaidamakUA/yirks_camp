extends "../Character.gd"


onready var brain: Brain = Brain.new(self)
onready var navigator: Navigator = Navigator.new()


func _ready():
	var scene_root = get_tree().current_scene
	self.connect("dying", scene_root, "_on_Pioneeres_dying")
	if $Actions:
		brain.set_actions($Actions.get_children())
	brain.start()

func _on_HurtBox_area_entered(area):
	die()
