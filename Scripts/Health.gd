extends Node2D


export (int) var health = 100 setget set_health

func set_health(new_health: int):
	health = clamp(new_health, 0, 100)
### Emit signal health change in the future

func get_health():
	return health

