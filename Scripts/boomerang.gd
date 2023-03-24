extends "res://Scripts/Bullet.gd"

export var boomTime = 3
var travTime = 0

func boomerang(delta):
	if boomTime > travTime:
		travTime += delta
	else:
		speed*=-1
	
