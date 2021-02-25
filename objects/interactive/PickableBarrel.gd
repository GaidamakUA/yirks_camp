extends BaseInteractiveObject

signal barrel_picked(barrel_textrue, barrel_rect)

func _interact():
	emit_signal("barrel_picked", $Sprite.texture, $Sprite.region_rect)
	queue_free()
