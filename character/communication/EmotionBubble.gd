tool

extends Node2D

signal finished_emotion

onready var _background_sprite: Sprite = $EmotionBackground
onready var _emotion_sprite: Sprite = $EmotionForeground
onready var animation_player = $AnimationPlayer

var is_ready := false

func _ready():
	is_ready = true
	
func show_emotion(background: Texture, foreground: Texture):
	if not is_ready:
		yield(self, "ready")
	_background_sprite.texture = background
	_emotion_sprite.texture = foreground
	_indicate()

func _indicate():
	animation_player.play("indicate")


func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("finished_emotion")
