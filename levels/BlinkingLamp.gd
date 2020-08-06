extends WallLamp

onready var initial_energy = light.energy
onready var flicker_timer = $ChangeBrightnessTimer

func _ready():
	flicker_timer.start(rand_range(0, 0.3))

func _on_ChangeBrightnessTimer_timeout():
	light.energy = rand_range(0, initial_energy)
	flicker_timer.start(rand_range(0, 0.3))
