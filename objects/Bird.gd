extends Sprite

onready var animationPlayer = $AnimationPlayer
onready var timer = $Timer

func _on_AnimationPlayer_animation_finished(anim_name):
	frame = 1
	var delay = rand_range(3, 10)
	timer.start(delay)

func _on_Timer_timeout():
	var animation = randi() % 3
	match animation:
		0: animationPlayer.play("neck")
		1: animationPlayer.play("jump")
		2: animationPlayer.play("peck")
