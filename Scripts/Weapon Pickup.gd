extends Node2D

signal newweapon(behavior)

var behavior = "mArrow"


func _ready():
	pass # Replace with function body.

func _on_Pickup_area_body_entered(body):
	emit_signal("newweapon", behavior)
	print("Weapon Pickup")
	queue_free()
