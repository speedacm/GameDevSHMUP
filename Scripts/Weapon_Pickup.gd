extends Node2D
@export var player : NodePath
@onready var pickupprompt = get_node("PickupPrompt")
## UI Variables


var canpickup = false
signal new_weapon(guntype, ammo)
var ammo = 12

func _ready():

	
	pass # Replace with function body.

func _on_Pickup_area_body_entered(body):
	print("Player entered pickup range")
	if "Player" in body.name:
		pickupprompt.visible = true
		canpickup = true
		

func _on_Pickup_area_body_exited(body):
	if "Player" in body.name:
		pickupprompt.visible = false
		canpickup = false

func _on_Player_pickuprequest():
	if(canpickup == true):
		var flamethrower = preload("res://Scenes/Flamethrower.tscn")
		emit_signal("new_weapon", flamethrower, ammo)
		print("Weapon Pickup")
		queue_free()





