extends StaticBody2D

func _ready():
	$AnimationPlayer.play("burn")

func _on_Hitbox_area_entered(area):
	area.get_parent().take_damage(global_position)
