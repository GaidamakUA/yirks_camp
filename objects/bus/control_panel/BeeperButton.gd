extends BaseClickableArea

signal beeping

onready var sprite = $BeeperSprite

func _on_pressed():
	sprite.hide()
	emit_signal("beeping")

func _on_released():
	sprite.show()
