extends KinematicBody2D

signal interaction_finished

export(int) var acceleration := 400
export(int) var max_speed := 80
export(int) var friction := 400

onready var animation_tree = $AnimationTree
onready var state_machine = animation_tree["parameters/playback"]
onready var emotion_bubble := $EmotionBubble
onready var dialog := $DialogPosition

var _direction := Vector2.ZERO
var last_direction := Vector2.ZERO
var velocity := Vector2.ZERO

var interactive_object

func _ready():
	animation_tree.active = true
	emotion_bubble.hide()
	_set_last_direction(Vector2.DOWN)
	if $Brain:
		$Brain.start()

func _on_direction(new_direction: Vector2):
	_direction = new_direction.normalized()
	if new_direction.is_equal_approx(Vector2.ZERO):
		state_machine.travel("Resting")
		pass
	else:
		state_machine.travel("Run")
		_set_last_direction(_direction)

func _physics_process(delta):
	if _direction.is_equal_approx(Vector2.ZERO):
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	else:
		velocity = velocity.move_toward(max_speed * _direction, acceleration * delta)
	velocity = move_and_slide(velocity)

func interact():
	if interactive_object == null:
		return
	if interactive_object.get_parent() is EatInetaction:
		$Energy.eat_pioneeres()
	interactive_object.interact()

func _set_last_direction(direction: Vector2):
	last_direction = direction
	animation_tree.set("parameters/Resting/blend_position", direction)
	animation_tree.set("parameters/Run/blend_position", direction)
	animation_tree.set("parameters/Dash/blend_position", direction)

func _on_InteractBox_area_entered(area):
	if area.get_collision_layer_bit(6):
		interactive_object = area
		interactive_object.connect("finished_interaction", self, "_on_interaction_finished")

func _on_InteractBox_area_exited(area):
	if area.get_collision_layer_bit(6) && interactive_object == area:
		interactive_object.disconnect("finished_interaction", self, "_on_interaction_finished")
		interactive_object = null

func _on_interaction_finished():
	emit_signal("interaction_finished")

func play_extra_animation(animation_name: String, is_terminal := false):
	$ExtraAnimationsPlayer.play(animation_name)
	
	$Sprite.hide()
	$ExtraSprite.show()
	
	yield($ExtraAnimationsPlayer, "animation_finished")
	
	if not is_terminal:
		$Sprite.show()
		$ExtraSprite.hide()

func serialize() -> Dictionary:
	var dict := {
		"filename" : get_filename(),
		"last_direction_x" : last_direction.x,
		"last_direction_y" : last_direction.y,
		"pos_x" : position.x,
		"pos_y" : position.y,
	}
	return dict

func deserialize(data: Dictionary):
	last_direction.x = data["last_direction_x"]
	last_direction.y = data["last_direction_y"]
	position.x = data["pos_x"]
	position.y = data["pos_y"]
