extends AtomicAction

class_name AttackAction

var _actor

func _perform():
	_actor = brain.actor
	_actor.attack()

func drop():
	pass

func _on_replica_finished():
	pass
	#TODO handle_result

func _to_string() -> String:
	return "AttackAction"
