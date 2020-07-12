extends Node2D

onready var actions = $Actions.get_children()
onready var actor = get_parent()

func start():
	print(actions)
	_perform_next_action()

func action_finished(action: AtomicAction):
	print(self, " action ", action, " finished")
	if actions.empty():
		actions = $Actions.get_children()
	_perform_next_action()

func _perform_next_action():
	var action: AtomicAction = actions.pop_front()
	print("next_Action: ", action)
	action.perform(self)
	if action.icon != "":
		actor.emotion_bubble.show_emotion(action.icon)
