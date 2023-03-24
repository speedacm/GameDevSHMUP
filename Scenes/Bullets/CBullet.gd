extends KinematicBody2D

export var smokeScene : PackedScene
export var bulletImpact : PackedScene
export var dmgNumberScene : PackedScene
export var bulletScene : PackedScene
export var numBullets :int
export var dFromCenter : float 
export var rSpeed  : int

var bullets = []
## UI Variables
var floating_text = preload("res://Scenes/UI/Floating_Text.tscn")

## Bullet Variables
var speed = 20
var dmg = 10
var direction = Vector2.ZERO
export var bouncy = false
export var bouncesLeft = 0
var parent = ''


# Called when the node enters the scene tree for the first time.
func _ready():
	
	if parent == "mobs":
		set_collision_layer_bit(31, true)
		set_collision_mask_bit(0, true)
		set_collision_mask_bit(1, false)
		set_collision_mask_bit(2, true)
	elif parent == "player":
		set_collision_layer_bit(31, true)
		set_collision_mask_bit(0, true)
		set_collision_mask_bit(1, true)
		
		for i in range (0, numBullets):
			var bulettExample = bulletScene.instance()
			bulettExample.set_global_position(Vector2(pow(-1,i)*dFromCenter, -1*pow(-1,i)*dFromCenter+i))
			bullets.append(bulettExample)
			self.add_child(bullets[i])


func set_speed(s):
	speed = s


func _process(delta):
	rotation += rSpeed * delta
## Bullet Checks what group it is in and acts accordingly
	
	boomerang(delta)
	var collisionResult = move_and_collide(direction*speed * delta)
	if collisionResult != null:
		
		#Get group at collision
		if collisionResult.collider.is_in_group("mobs"):
			
			# Doing Damage
			collisionResult.collider.health.set_health(collisionResult.collider.health.get_health()-dmg)
			# Display dmg value as text
			var dmgnumbers = dmgNumberScene.instance()
			get_parent().add_child(dmgnumbers)
			dmgnumbers.set_text(dmg as String)
			dmgnumbers.global_position = dmgnumbers.place(collisionResult.position)
			
		
		if collisionResult.collider.is_in_group("player"):
			# Taking Damage
			collisionResult.collider.health.set_health(collisionResult.collider.health.get_health()-dmg)
			# Displaying DMG taken
		 
		
		
### Bullet Effects (Smoke and Impact)

		var smoke = smokeScene.instance() as Particles2D
		get_parent().add_child(smoke)
		smoke.global_position = collisionResult.position
		smoke.rotation = collisionResult.normal.angle()
		
		var impact = bulletImpact.instance() as Node2D
		get_parent().add_child(impact)
		impact.global_position = collisionResult.position
		impact.rotation = collisionResult.normal.angle()
		
		if (bouncy):

			
			bouncesLeft-= 1
			direction =direction.bounce(collisionResult.get_normal())
			if bouncesLeft == 0:
				bouncy = false
			
			
		else: 
			queue_free()
		
		
### BOOMERANG?
export var boomTime = 0
var travTime = 0
var boomeranged = false

func boomerang(delta):
	if boomTime > travTime:
		travTime += delta
	elif travTime >0 and not boomeranged:
		### turn it around
		speed*=-1
		boomeranged = true
	


