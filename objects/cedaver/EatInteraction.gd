extends BaseInteractiveObject

class_name EatInetaction

var interacting := false

func _interact():
	if interacting:
		return
	interacting = true
	$YeerkPalm.hide()
	$Consupption.show()
	$Consupption.play()
	yield($Consupption, "animation_finished")
	queue_free()
