extends "../Character.gd"

export(Array, Resource) var todo_list := Array()

onready var navigation = $Navigation
onready var activity_timer = $ChangeActivity
onready var delay_timer = $DelayTimer

var current_action

func _ready():
	var scene_root = get_tree().current_scene
	self.connect("dying", scene_root, "_on_Pioneeres_dying")

func _process(delta):
	if current_action:
		if current_action is GoToAction:
			var direction = navigation.get_direction()
			_on_direction(direction)
	elif not todo_list.empty():
		current_action = todo_list.pop_front()
		if current_action:
			current_action.perform(self)

func _on_HurtBox_area_entered(area):
	die()

func go_to(destination: Vector2):
	print("_go_to: ", destination)
	navigation.set_destination(destination)

func _on_Navigation_arrived():
	current_action = null

func wait(seconds: float):
	delay_timer.start(seconds)
