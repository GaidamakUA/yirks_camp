extends AtomicAction

class_name AttackAction

var _actor
var timer = Timer.new()

func _ready():
	timer.connect("timeout", self, "_on_animation_finished")

func _perform():
	_actor = brain.actor
	yield(_actor.play_extra_animation(_get_animation_name()), "completed")
	_notify_done()

func _get_animation_name():
	var direction: Vector2 = _actor.last_direction
	print("direction ", direction)
	var x = direction.x
	var y = direction.y
	var animation_name: String
	if abs(x) > abs(y):
		if x > 0:
			return "attack_right"
		else:
			return "attack_left"
	else:
		if y > 0:
			return "attack_down"
		else:
			return "attack_up"

func drop():
	pass

func _to_string() -> String:
	return "AttackAction"
