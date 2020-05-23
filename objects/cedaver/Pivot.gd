extends Node2D

func _ready():
	_init_random_sprite()

func _init_random_sprite():
	_randomize_blood()
	_randomize_sprite()

func _randomize_sprite():
	var random_frame = randi() % 4
	$Sprite.frame = random_frame
	if random_frame == 0 || random_frame == 2:
		if randi() % 2 == 0:
			scale.x = -1
		rotate(randf() * PI * 2)
	else:
		rotate(randf() * PI / 3 - PI / 6)

func _randomize_blood():
	_move_up($Blood/blood_splat_0, randi() % 16)
	_randomize_orientation($Blood/blood_splat_0)
	_move_up($Blood/blood_splat_1, randi() % 32)
	_randomize_orientation($Blood/blood_splat_1)
	_move_up($Blood/blood_splat_2, randi() % 24)
	_randomize_orientation($Blood/blood_splat_2)
	if randi() % 2 == 0:
		scale.x = -1

func _randomize_orientation(victim: Node2D):
	pass
	if randi() % 2 == 0:
		victim.scale.x = -1
	if randi() % 2 == 0:
		victim.scale.y = -1

func _move_up(victim: Node2D, delta_y):
	var victim_position = victim.position
	victim_position.y -= delta_y
	victim.position = victim_position
