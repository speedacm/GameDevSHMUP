extends Label



# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_ammohudupdate(ammo, equippedweapon):
	if(equippedweapon.type == "Flamethrower"):
		text = "Flames: "
	elif(equippedweapon.type == "Peashooter"):
		text = "Peas "
	pass # Replace with function body.
