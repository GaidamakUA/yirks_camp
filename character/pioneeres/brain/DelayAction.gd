extends AtomicAction

class_name DelayAction

export(float, 1, 30) var wait_time

func perform(actor):
	actor.wait(wait_time)
