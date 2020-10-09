tool
extends BaseInteractiveObject

export var is_activated: bool = false setget _activated_changed

onready var animated_sprite = $AnimatedSprite

func _ready():
	pass # Replace with function body.

func _interact():
	self.is_activated = not is_activated

func _activated_changed(value: bool):
	is_activated = value
	if value:
		animated_sprite.play("", true)
	else:
		animated_sprite.play()

func _on_AnimatedSprite_animation_finished():
	animated_sprite.stop()
