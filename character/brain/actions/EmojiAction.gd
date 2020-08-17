extends AtomicAction

class_name EmojiAction, "res://assets/class_icons/emoticon-happy-outline.png"

export(Texture) var background
export(Texture) var emoji_icon

var emotion_buble

func _perform():
	emotion_buble = brain.actor.emotion_bubble
	emotion_buble.show_emotion(background, emoji_icon)
	emotion_buble.connect("finished_emotion", self, "_on_emoji_finished")

func drop():
	emotion_buble.disconnect("finished_emotion", self, "_on_emoji_finished")

func _on_emoji_finished():
	emotion_buble.disconnect("finished_emotion", self, "_on_emoji_finished")
	_notify_done()

func _to_string() -> String:
	return "EmojiAction"
