extends KinematicBody2D
class_name TestPlayer
onready var animation_player = $AnimationPlayer
onready var defaultweapon = get_node("Weapon")

## Player Variables
export var speed = 200
var velocity = Vector2.ZERO
var direction

onready var health = $Health
var flipped = false

## Weapon Variables
onready var equippedweapon = $Weapon
var weaponbehavior

## UI Variables
signal pickuprequest
signal hphudupdate(new_health) 

### Player Movement Controls

func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('right'):
		velocity.x += 1
		direction = "right"
	if Input.is_action_pressed('left'):
		velocity.x -= 1
		direction = "left"
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	if Input.is_action_pressed("Pickup"):
		emit_signal("pickuprequest")
# Added sprint so i can test level quicker
#	if Input.is_action_pressed("sprint"):
#		speed = 250
#	if Input.is_action_just_released("sprint"):
#		speed = 200
	
	
### Shooting Function

func shoot(bullet, location: Vector2, direction: Vector2):
	emit_signal("player_fired_bullet", bullet,location,direction)

func _unhandled_input(event):
	if (event.is_action_pressed("shoot")):
		equippedweapon.shoot()


### Check if Dead
func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)
	if velocity.x > 0:
		if not flipped:
			animation_player.play("walk_right")
		elif flipped:
			animation_player.play("walk_right_back")
	elif velocity.x < 0:
		if not flipped:
			animation_player.play("walk_left")
		elif flipped:
			animation_player.play("walk_left_back")
	elif velocity.y > 0:
		animation_player.play("walk_down")
	elif velocity.y < 0:
		animation_player.play("walk_up")
	else:
		animation_player.play("idle_right")
	if health.health <= 0:
		queue_free()


### 
func _process(_delta):
	flipped = flip()
	pass
	

# Flips player and gun when looking in a different direction
func flip():
	var flip = sign(get_global_mouse_position().x - $TestSprite.global_position.x)
	if velocity.x >= 0:
		if flip < 0:
			$TestSprite.set_flip_h(true)
#			$GunModel.set_flip_v(true)
			return true
		else:
			$TestSprite.set_flip_h(false)
#			$GunModel.set_flip_v(false)
			return false
	if velocity.x < 0:
		if flip < 0:
			$TestSprite.set_flip_h(false)
#			$GunModel.set_flip_v(false)
			return false
		else:
			$TestSprite.set_flip_h(true)
#			$GunModel.set_flip_v(true)
			return true

func equip_weapon(weapon):
	equippedweapon = weapon


func _on_Flamepick_new_weapon(guntype, ammo):
	equippedweapon.queue_free()
	var flamethrower = guntype.instance()
	add_child(flamethrower)
	equip_weapon(flamethrower)
	equippedweapon.ammo = ammo

func _on_out_of_ammo():
	equippedweapon.queue_free()
	add_child(defaultweapon)
	equip_weapon(defaultweapon)
	
	


func _on_Health_healthchangeplayer(new_health):
	emit_signal("hphudupdate",new_health)
	pass # Replace with function body.
