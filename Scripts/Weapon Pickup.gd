extends Node2D

signal new_weapon(guntype, ammo)
var ammo = 5

func _ready():
	pass # Replace with function body.

func _on_Pickup_area_body_entered(body):
	var flamethrower = preload("res://Scenes/Flamethrower.tscn")
	emit_signal("new_weapon", flamethrower, ammo)
	print("Weapon Pickup")
	queue_free()
