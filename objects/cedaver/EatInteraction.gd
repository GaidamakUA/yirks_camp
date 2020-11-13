extends BaseInteractiveObject

class_name EatInetaction

var interacting := false

func _interact():
	if interacting:
		return
	interacting = true
	$YeerkPalm.hide()
	$Consumption.show()
	$Consumption.play()
	yield($Consumption, "animation_finished")
	queue_free()
