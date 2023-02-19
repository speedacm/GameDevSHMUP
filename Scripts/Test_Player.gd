extends KinematicBody2D
class_name TestPlayer
onready var animation_player = $AnimationPlayer
onready var defaultweapon = get_node("Weapon")

## Player Variables
export var speed = 200
export var iTime = .2
var velocity = Vector2.ZERO
var direction
var detectorID: Node
var is_dodging = false
export var DODGE_TIME = 20
var dodgeTime = 0
export var dodgeSpeed = 2
export var friction = 1
onready var health = $Health
var flipped = false



## Weapon Variables
onready var equippedweapon = $Weapon
var weaponbehavior

## UI Variables
signal pickuprequest
signal hphudupdate(new_health) 
signal ammohudupdate(ammo, equippedweapon)
signal playerDied()

func _ready():
	#Sets Collision Layers
	setlayers()
	
	
### Shooting Function

	
	
func _unhandled_input(event):
	if (event.is_action_pressed("shoot")):
		equippedweapon.shoot()


func _physics_process(_delta):
	
	### Movement --------- 
	if dodgeTime - iTime <= 0: 
		$Health.isVuln = true
	if dodgeTime == 0:
		var direction := Vector2(
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			Input.get_action_strength("down") - Input.get_action_strength("up")
		)
	####normalize
		
		if direction.length() > 1.0:
			direction = direction.normalized()
	### Joystick works?
	# Using the follow steering behavior.
	###friction stuff for ice floors??????
		var target_velocity = direction * speed
		velocity += (target_velocity - velocity) * friction
		if Input.is_action_just_pressed("sprint") && (velocity.x != 0.0 or velocity.y != 0.0):
				$Health.isVuln = false
				dodgeTime = DODGE_TIME
				velocity = velocity* dodgeSpeed
	###move
	else:
		dodgeTime = max(0, dodgeTime-.1)
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
		emit_signal("playerDied")
		self.visible = false



### 
func _process(_delta):
	## ammo hud update every frame
	emit_signal("ammohudupdate",equippedweapon.ammo, equippedweapon)
	
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
	equippedweapon.visible = true
	add_child(equippedweapon)
	
func unequip_weapon(weapon):
	## If this is the deafult weapon, disable it
	if weapon == defaultweapon:
		weapon.visible = false
		remove_child(weapon)
	else:
		weapon.queue_free()

func _on_Flamepick_new_weapon(guntype, ammo):
	
	unequip_weapon(equippedweapon)
	var flamethrower = guntype.instance()
	equip_weapon(flamethrower)
	equippedweapon.ammo = ammo
	emit_signal("ammohudupdate",equippedweapon.ammo, equippedweapon)

func _on_out_of_ammo():
	print("just got told i was out of ammo - player script")
	unequip_weapon(equippedweapon)
	equip_weapon(defaultweapon)
	emit_signal("ammohudupdate",equippedweapon.ammo, equippedweapon)
	
	


func _on_Health_healthchangeplayer(new_health):
	emit_signal("hphudupdate",new_health)
	pass # Replace with function body.
	
#Sets Collision Layers
func setlayers():
	
	## Exists on layer
	set_collision_layer_bit(layer.PLAYER, true)
	
	## Collide with layer
	set_collision_mask_bit(layer.WALLS, true)
	set_collision_mask_bit(layer.ENEMY, true)
	


func _on_RoomDetector_area_entered(area: Area2D) -> void:
	
	print("Enter Room")
	detectorID = area
	
	var collision_shape = area.get_node("CollisionShape2D")
	var size = collision_shape.shape.extents * 2 * 2
	var x_offset = 248
	var y_offset = 200
	
	var cam = $Camera2D
	cam.limit_top = collision_shape.global_position.y - y_offset - size.y/2
	cam.limit_left = collision_shape.global_position.x + x_offset - size.x/2
	
	cam.limit_bottom = cam.limit_top + size.y
	cam.limit_right = cam.limit_left + size.x

