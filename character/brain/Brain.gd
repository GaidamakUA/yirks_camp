extends Node2D

export(int, 1, 20) var think_frequency := 20

var DEBUGGING := false

#Action dependencies
onready var actor = get_parent()
onready var navigation = $Navigation
onready var hand_reach_sensor: Area2D = $HandReachSensor
onready var bladder: Bladder = $Bladder
onready var sight_cone: Area2D = $EyesightConeSensor
onready var direct_sight_sensor: RayCast2D = $DirectSightSensor
onready var hit_reach_sensor: Area2D = $HitReachSensor

onready var timer = Timer.new()

var goals
var current_goal
var _is_started := false

func _ready():
	var goals_node = find_node("Goals")
	goals = goals_node.get_children()
	add_child(timer)
	timer.connect("timeout", self, "_think")

func die():
	current_goal.drop()
	timer.stop()

func start():
	_think()
	_is_started = true

func _process(delta):
	if DEBUGGING:
		$DebugText.text = str(current_goal)

func _think():
	_update_weights()
	_sort_goals()
	if not goals.empty():
		var top_goal = goals[0]
		if top_goal != current_goal || current_goal.is_finished():
			if current_goal != null:
				current_goal.drop()
			current_goal = top_goal
			current_goal.persue()
	timer.start(1 / think_frequency)

func _update_weights():
	for goal in goals:
		goal.update_weight()

func _sort_goals():
	goals.sort_custom(self, "_goals_comparator")

func _goals_comparator(a, b) -> bool:
	return a.weight > b.weight

func serialize() -> Dictionary:
	var goal_data := []
	for goal in goals:
		goal_data.append(goal.serialize())
	var data := {
		"script" : get_filename(),
		"goal_data" : goal_data
	}
	if bladder:
		data["bladder"] = bladder.serialize()
	return data

func deserialize(data: Dictionary):
	timer.stop()

	if data.has("bladder"):
		var new_bladder = Node2D.new()
		var bladder_script = load(data["bladder"]["script"])
		new_bladder.set_script(bladder_script)
		new_bladder.deserialize(data["bladder"])
		bladder = new_bladder
		add_child(bladder)
	
	var goals_node := Node2D.new()
	goals_node.name = "Goals"
	add_child(goals_node)
	goals = []
	var goal_scripts := Dictionary()
	var goals_data = data["goal_data"]
	for data in goals_data:
		var goal = Node.new()
		var script_name = data["script"]
		if not goal_scripts.has(script_name):
			goal_scripts[script_name] = load(script_name)
		var script = goal_scripts[script_name]
		goal.set_script(script)
		goal.deserialize(data)
		goals_node.add_child(goal)
		goals.append(goal)
	print("goals initialized")
	
	timer.start(1 / think_frequency)
