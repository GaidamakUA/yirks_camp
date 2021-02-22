tool
extends BaseAnimatedSpriteObject

func _activated_changed(value: bool):
	._activated_changed(value)
	if not is_initialized:
		yield(self ,"ready")
	$OpenedCollision/CollisionShape2D.disabled = not value
	$ClosedCollision/CollisionShape2D.disabled = value
	$ClosedCollision/CollisionShape2D2.disabled = value
