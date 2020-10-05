extends Node2D

export(int, 1, 20) var think_frequency := 5

#Action dependencies
onready var actor = get_parent()
onready var navigation = $Navigation
onready var hand_reach_sensor: Area2D = $HandReachSensor
onready var bladder: Bladder = $Bladder
onready var sight_cone: Area2D = $EyesightConeSensor

onready var timer = Timer.new()

onready var goals = $Goals.get_children()
var current_goal: BaseGoal
var _is_started := false

func _ready():
	add_child(timer)
	timer.connect("timeout", self, "_think")

func start():
	_think()
	_is_started = true

func _process(delta):
	if _is_started:
		pass

func _think():
	_update_weights()
	_sort_goals()
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

func _goals_comparator(a, b):
	return a.weight > b.weight
