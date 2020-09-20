extends BaseClickableArea

signal beeping

onready var sprite = $BeeperSprite

func on_pressed():
	sprite.hide()
	emit_signal("beeping")

func on_released():
	sprite.show()
