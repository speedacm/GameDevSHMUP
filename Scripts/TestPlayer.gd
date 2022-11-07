extends KinematicBody2D
class_name TestPlayer

onready var animation_player = $AnimationPlayer
export var bulletScene : PackedScene


## Player Variables
export var speed = 200
var velocity = Vector2.ZERO
var direction
onready var health = $Health


## Weapon Variables
onready var equippedweapon = $Weapon
var weaponbehavior

func _ready() -> void:
	pass

var flipped = false


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

## Called every frame

func _process(_delta):
	flipped = flip()
	pass


### Flips player and gun when looking in a different direction
func flip():
	var flip = sign(get_global_mouse_position().x - $TestSprite.global_position.x)
  
  

# old flip function
#	if flip < 0:
#		$TestSprite.set_flip_h(true)
#		weapon.GunModel.set_flip_v(true)
#	else:
#		$TestSprite.set_flip_h(false)
#		weapon.GunModel.set_flip_v(false)

### Sends weapon behavior information from weapon pickup to child node


func _on_Flamepickup_new_weapon(guntype, ammo):
	equippedweapon.queue_free()
	var flamethrower = guntype.instance()
	add_child(flamethrower)
	equip_weapon(flamethrower)

	if velocity.x >= 0:
		if flip < 0:
			$TestSprite.set_flip_h(true)
			#$GunModel.set_flip_v(true)
			return true
		else:
			$TestSprite.set_flip_h(false)
			#$GunModel.set_flip_v(false)
			return false
	if velocity.x < 0:
		if flip < 0:
			$TestSprite.set_flip_h(false)
			#$GunModel.set_flip_v(false)
			return false
		else:
			$TestSprite.set_flip_h(true)
			#$GunModel.set_flip_v(true)
			return true


func equip_weapon(weapon):
	equippedweapon = weapon
	
	
	
	
