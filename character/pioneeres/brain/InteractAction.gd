extends AtomicAction

class_name InteractAction

func perform(actor):
	actor.interact()
	actor._on_Navigation_arrived()
