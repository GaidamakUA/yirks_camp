extends Sprite

func _ready():
	$AnimationPlayer.play("New Anim")

func _on_Timer_timeout():
	queue_free()
