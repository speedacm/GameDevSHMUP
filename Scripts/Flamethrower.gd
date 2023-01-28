extends Node2D

export var bulletScene : PackedScene

onready var gunmodel = $GunModel
onready var muzzle = $GunModel/muzzle
onready var timer = $Bursttimer
onready var cooldowntimer = $"Attack Cooldown"

var type = "Flamethrower"

func _ready():
	 get_parent().connect("out_of_ammo",self, "_on_out_of_ammo")

## Weapon Variables
var rateofburst = 0.15 # time between bullets in burst
var burstamount = 2 # burst amount is n-1 what burst it is (3 round burst is 2)
var shotsfired = 0
var ammo = 0

## Attack Cool down
var rateoffire = 0.5
var canfire = true


signal weapon_fired(bullet, location, direction)
signal out_of_ammo()

func set_ammo(new_ammo: int):
	ammo = clamp(new_ammo, 0 ,100)

func shoot(): 
	if(canfire == true && ammo != 0):
		
		## Basic Shoot Function
		var bullet = bulletScene.instance() as Node2D
		bullet.set('parent', 'player')
		get_parent().get_parent().add_child(bullet)
		emit_signal("weapon_fired",bullet)
		bullet.global_position = $GunModel/muzzle.global_position
		bullet.direction = (get_global_mouse_position() - global_position).normalized()
		bullet.rotation = bullet.direction.angle()
		
		timer.start(rateofburst)
		gunmodel.visible = true
		cooldowntimer.start(rateoffire)
		canfire = false

## basically part of shooting function
func _on_attackcooldown_timeout():
	canfire = true
	shoot()
	shotsfired += 1
	timer.stop()
	if( shotsfired < burstamount):
		timer.start()
		
	else:
		ammo -= shotsfired + 1
		if(ammo == 0):
			print("Im out of ammo!!!!")
			self.connect("out_of_ammo", self.get_parent(),"_on_out_of_ammo")
			emit_signal("out_of_ammo")
		shotsfired = 0
		canfire = false
		return



func _on_Attack_Cooldown_timeout():
	canfire = true
	gunmodel.visible = false
	
