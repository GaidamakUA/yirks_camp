extends Sprite

onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.play("splash")

func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()
