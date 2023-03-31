extends Node2D

export var bulletScene : PackedScene



onready var gunmodel = $GunModel
onready var muzzle = $GunModel/muzzle
var type = "Peashooter"
var ammo = 0


signal weapon_fired(bullet, location, direction)


func shoot(): 
		var bullet = bulletScene.instance() as Node2D
		bullet.set('parent', 'testmain')
		get_parent().get_parent().add_child(bullet)
		emit_signal("weapon_fired",bullet)
		bullet.global_position = $GunModel/muzzle.global_position
		bullet.direction = (get_global_mouse_position() - global_position).normalized()
		bullet.rotation = bullet.direction.angle()
		


	


