extends CanvasLayer

var max_value = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	$healthBar.value = max_value
	pass # Replace with function body.

func _on_Player_hphudupdate(new_health):
	$healthBar.value = new_health
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_Player_ammohudupdate(ammo, equippedweapon):
	if(equippedweapon.type == "Flamethrower"):
		$weaponLabel.text = "Flames: "
	elif(equippedweapon.type == "Peashooter"):
		$weaponLabel.text = "Peas "
	if(ammo != 0):
		$ammoCounter.visible = true
		$ammoCounter.text = ammo as String
	elif(ammo == 0):
		$ammoCounter.visible = false
	pass # Replace with function body.
	
func _on_Player_playerDied():
	$"Death Screen".visible = true;
	pass # Replace with function body.



func _on_Instructions_starthud():
	#uncomment to enable FPS counter
	#$fpsCounter.visible = true 
	$healthBar.visible = true
	$hpLabel.visible = true
	$weaponLabel.visible = true
	$ammoCounter.visible = true
	$Timer.visible = true
	pass # Replace with function body.
