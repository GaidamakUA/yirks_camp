extends "../Character.gd"

class_name Player

var dash_distance: float = 200
export(float) var dash_time := 0.7

const Afterimage = preload("res://character/player/PlayerAfterimage.tscn")
const Splash = preload("res://objects/Splash.tscn")

const yeerk_underwater = preload("res://assets/yeerk_underwater.png")
const yeerk_land = preload("res://assets/yeerk.png")

onready var tween = $DashTween
onready var hitbox = $HitBox
onready var spawn = $Spawn
onready var idle_timer = $Idle
onready var dash_raycast = $DashCollision

func _ready():
	$Sprite.texture = yeerk_land

func _physics_process(_delta):
	if tween.is_active() && dash_raycast.is_colliding():
		tween.seek(tween.tell() - 0.02)
		tween.remove_all()
		spawn.stop()

func _process(_delta):
	if tween.is_active():
		return
	if Input.is_action_just_pressed("dash"):
		_play_dash()
		return

	var new_direction = Vector2.ZERO

	new_direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	new_direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if new_direction.is_equal_approx(Vector2.ZERO):
		if idle_timer.is_stopped():
			var random_time := rand_range(4, 7)
			idle_timer.start(random_time)
	else:
		if not idle_timer.is_stopped():
			idle_timer.stop()
	
	_on_direction(new_direction)

func _unhandled_input(event):
	if event.is_action_pressed("interact"):
		interact()

func _play_dash():
	print(last_direction)
	state_machine.travel("Dash")
	var start: Vector2 = position
	var finish: Vector2 = position + dash_distance * last_direction
	tween.interpolate_property(self, "position", start, finish, dash_time,  Tween.TRANS_BACK,  Tween.EASE_IN)
	tween.start()
	spawn.start()
	dash_raycast.look_at(finish)

func _on_Spawn_timeout():
	var afterimage: Sprite = Afterimage.instance()
	var sprite = $Sprite
	afterimage.global_position = sprite.global_position
	afterimage.frame = sprite.frame
	var world = get_parent()
	world.add_child(afterimage)

func _on_DashTween_tween_all_completed():
	spawn.stop()

func _on_Idle_timeout():
	state_machine.travel("Idle")

func _on_entered_water(body):
	var splash: Sprite = Splash.instance()
#	var sprite = $Sprite
#	splash.global_position = sprite.global_position + Vector2(0, 8)
	splash.position = Vector2(0, -20)
	add_child(splash)
	
	$Sprite.texture = yeerk_underwater
	print("entered ", body)

func _on_exited_water(body):
	$Sprite.texture = yeerk_land
	print("exited ", body)

func _on_InteractBox_area_entered(area):
	._on_InteractBox_area_entered(area)
	area.show_palm()

func _on_InteractBox_area_exited(area):
	._on_InteractBox_area_entered(area)
	area.hide_palm()
