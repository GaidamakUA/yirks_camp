extends "../Character.gd"

var directions = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT, Vector2.ZERO]
var direction = Vector2.ZERO
onready var activity_timer = $ChangeActivity

func _ready():
	_regenerate_direction()

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
	print("direction: ", direction, " time:", time)

func _on_HurtBox_area_entered(area):
	die()
