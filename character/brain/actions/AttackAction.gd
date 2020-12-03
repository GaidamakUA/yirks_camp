extends AtomicAction

class_name AttackAction

var timer = Timer.new()

func _ready():
	timer.connect("timeout", self, "_on_animation_finished")

func _perform():
	var actor = brain.actor
	yield(actor.play_extra_animation(_get_animation_name()), "completed")
	_notify_done()

func _get_animation_name():
	var direct_sight: RayCast2D = brain.direct_sight_sensor
	var rotation = direct_sight.rotation
	print("rotation ", rotation)
	if rotation > 7 * PI / 4 || rotation < PI / 4:
		return "attack_right"
	if rotation > 5 * PI / 4:
		return "attack_up"
	if rotation > 3 * PI / 4:
		return "attack_left"
	if rotation > PI / 4:
		return "attack_down"

func drop():
	pass

func _to_string() -> String:
	return "AttackAction"
