extends "../Character.gd"

var directions = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT, Vector2.ZERO]
var direction = Vector2.ZERO
onready var activity_timer = $ChangeActivity

func _ready():
	_regenerate_direction()
	var scene_root = get_tree().current_scene
	self.connect("dying", scene_root, "_on_Pioneeres_dying")

func _process(delta):
	_on_direction(direction)
	var should_move = direction != Vector2.ZERO
	var is_stopped = velocity.is_equal_approx(Vector2.ZERO)
	if (should_move && is_stopped):
		_regenerate_direction()

func _regenerate_direction():
	var time := rand_range(1, 5)
	activity_timer.start(time)
	var random_index = randi() % 5
	direction = directions[random_index]
	
	_show_random_emotion()

func _show_random_emotion():
	var emotions = [
		"alert",
		"anger",
		"bars",
		"cash",
		"circle",
		"cloud",
		"cross",
		"dots1",
		"dots2",
		"dots3",
		"drop",
		"drops",
		"exclamation",
		"exclamations",
		"faceAngry",
		"faceHappy",
		"faceSad",
		"heart",
		"heartBroken",
		"hearts",
		"idea",
		"laugh",
		"music",
		"question",
		"sleep",
		"sleeps",
		"star",
		"stars",
		"swirl"
	]
	var random_emotion = emotions[randi() % emotions.size()]
	emotion_bubble.show_emotion(random_emotion)

func _on_HurtBox_area_entered(area):
	die()
