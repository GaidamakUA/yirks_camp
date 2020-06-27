extends AtomicAction

class_name GoToAction

export(Vector2) var target

func perform(actor):
	actor.go_to(target)
