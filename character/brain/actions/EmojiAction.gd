extends AtomicAction

class_name EmojiAction, "res://assets/class_icons/emoticon-happy-outline.png"

export(Texture) var background
export(Texture) var emoji_icon

var emotion_buble

func _perform():
	emotion_buble = brain.actor.emotion_bubble
	emotion_buble.show_emotion(background, emoji_icon)
	yield(emotion_buble, "finished_emotion")
	_notify_done()

func drop():
	emotion_buble.hide()
	_notify_done()

func _to_string() -> String:
	return "EmojiAction"
