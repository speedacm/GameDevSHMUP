extends Node2D

signal healthchangeplayer(new_health)
signal healthchangeenemy(new_health)

var isVuln = true
export (int) var health = 100 setget set_health

func set_health(new_health: int):
	if isVuln:
		health = clamp(new_health, 0, 1000)
		emit_signal("healthchangeplayer",new_health)
		emit_signal("healthchangeenemy", new_health)
### Emit signal health change in the future

func get_health():
	return health

