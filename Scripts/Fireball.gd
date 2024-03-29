extends KinematicBody2D

export var smokeScene : PackedScene
export var bulletImpact : PackedScene
export var dmgNumberScene : PackedScene
## UI Variables
var floating_text = preload("res://Scenes/UI/Floating_Text.tscn")

## Bullet Variables
var dmg = 20
var speed = 400
var direction = Vector2.ZERO

var parent = ''


# Called when the node enters the scene tree for the first time.
func _ready():
	if parent == "mobs":
		set_collision_layer_bit(31, true)
		set_collision_mask_bit(0, true)
		set_collision_mask_bit(1, false)
		set_collision_mask_bit(2, true)
	else:
		set_collision_layer_bit(31, true)
		set_collision_mask_bit(0, true)
		set_collision_mask_bit(1, true)


func set_speed(s):
	speed = s


func _process(delta):

## Bullet Checks what group it is in and acts accordingly

	var collisionResult = move_and_collide(direction * speed * delta)
	if collisionResult != null:
		
		#Get group at collision
		if collisionResult.collider.is_in_group("mobs"):
			collisionResult.collider.health.set_health(collisionResult.collider.health.get_health()-dmg)
			# Displaying DMG value
			var dmgnumbers = dmgNumberScene.instance()
			get_parent().add_child(dmgnumbers)
			dmgnumbers.set_text(dmg as String)
			dmgnumbers.global_position = dmgnumbers.place(collisionResult.position)
		
		if collisionResult.collider.is_in_group("player"):
			collisionResult.collider.health.set_health(collisionResult.collider.health.get_health()-dmg)
		
		
### Bullet Effects (Smoke and Impact)

		var smoke = smokeScene.instance() as Particles2D
		get_parent().add_child(smoke)
		smoke.global_position = collisionResult.position
		smoke.rotation = collisionResult.normal.angle()
		
		var impact = bulletImpact.instance() as Node2D
		get_parent().add_child(impact)
		impact.global_position = collisionResult.position
		impact.rotation = collisionResult.normal.angle()
		queue_free()
		
