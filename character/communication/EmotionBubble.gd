tool

extends Node2D

export var emotion := "alert" setget _set_emotion

var styles_map: Dictionary = {
	"speaking_square": preload("res://assets/emotes/emote_0.png"),
	"speaking_square_blue": preload("res://assets/emotes/emote_1.png"),
	"speaking_round": preload("res://assets/emotes/emote_2.png"),
	"speaking_round_blue": preload("res://assets/emotes/emote_3.png"),
	"thinking": preload("res://assets/emotes/emote_4.png"),
	"thinking_blue": preload("res://assets/emotes/emote_5.png"),
	"speaking_thorny": preload("res://assets/emotes/emote_6.png")
}

var emotions: Dictionary = {
	"alert": preload("res://assets/emotes/emote_alert.png"),
	"anger": preload("res://assets/emotes/emote_anger.png"),
	"bars": preload("res://assets/emotes/emote_bars.png"),
	"cash": preload("res://assets/emotes/emote_cash.png"),
	"circle": preload("res://assets/emotes/emote_circle.png"),
	"cloud": preload("res://assets/emotes/emote_cloud.png"),
	"cross": preload("res://assets/emotes/emote_cross.png"),
	"dots1": preload("res://assets/emotes/emote_dots1.png"),
	"dots2": preload("res://assets/emotes/emote_dots2.png"),
	"dots3": preload("res://assets/emotes/emote_dots3.png"),
	"drop": preload("res://assets/emotes/emote_drop.png"),
	"drops": preload("res://assets/emotes/emote_drops.png"),
	"exclamation": preload("res://assets/emotes/emote_exclamation.png"),
	"exclamations": preload("res://assets/emotes/emote_exclamations.png"),
	"faceAngry": preload("res://assets/emotes/emote_faceAngry.png"),
	"faceHappy": preload("res://assets/emotes/emote_faceHappy.png"),
	"faceSad": preload("res://assets/emotes/emote_faceSad.png"),
	"heart": preload("res://assets/emotes/emote_heart.png"),
	"heartBroken": preload("res://assets/emotes/emote_heartBroken.png"),
	"hearts": preload("res://assets/emotes/emote_hearts.png"),
	"idea": preload("res://assets/emotes/emote_idea.png"),
	"laugh": preload("res://assets/emotes/emote_laugh.png"),
	"music": preload("res://assets/emotes/emote_music.png"),
	"question": preload("res://assets/emotes/emote_question.png"),
	"sleep": preload("res://assets/emotes/emote_sleep.png"),
	"sleeps": preload("res://assets/emotes/emote_sleeps.png"),
	"star": preload("res://assets/emotes/emote_star.png"),
	"stars": preload("res://assets/emotes/emote_stars.png"),
	"swirl": preload("res://assets/emotes/emote_swirl.png"),
}

onready var background: Sprite = $EmotionBackground
onready var _emotion_sprite: Sprite = $EmotionForeground
onready var animation_player = $AnimationPlayer

var is_ready := false

func _ready():
	is_ready = true
	
func show_emotion(new_emotion: String):
	_set_style("speaking_square")
	_set_emotion(new_emotion)
	_indicate()

func think_emotion(new_emotion: String):
	_set_style("thinking")
	_set_emotion(new_emotion)
	_indicate()

func _set_style(style_id: String):
	background.texture = styles_map[style_id]

func _set_emotion(emotion_id: String):
	if not is_ready:
		yield(self, "ready")
	emotion = emotion_id
	_emotion_sprite.texture = emotions[emotion_id]

func _indicate():
	animation_player.play("indicate")
