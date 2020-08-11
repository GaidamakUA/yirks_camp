extends Node2D

onready var actions = $Actions.get_children()
onready var actor = get_parent()
onready var navigation = $Navigation
onready var hand_reach_sensor: Area2D = $HandReachSensor

func start():
	print(actions)
	_perform_next_action()

func action_finished(action: AtomicAction):
	print(self, " action ", action, " finished")
	action.disconnect("done", self, "action_finished")
	if actions.empty():
		actions = $Actions.get_children()
	_perform_next_action()

func _perform_next_action():
	var action: AtomicAction = actions.pop_front()
	print("next_Action: ", action)
	action.connect("done", self, "action_finished")
	action.perform(self)
