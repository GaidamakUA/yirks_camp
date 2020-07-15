class_name Brain

var actions
var actor

func _init (_actor):
	actor = _actor
	
func set_actions(_actions):
	actions = _actions

func start():
	print('Brain works ',actor.name)
	if actions:
		_perform_next_action()

func action_finished(action: AtomicAction):
	print(self, " action ", action, " finished")
	_perform_next_action()

func _perform_next_action():
	var action: AtomicAction = actions.pop_front()
	print("next_Action: ", action)
	action.perform(actor)
	if action.icon != "":
		actor.emotion_bubble.show_emotion(action.icon)
