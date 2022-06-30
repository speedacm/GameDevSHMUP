extends KinematicBody2D

export var smokeScene : PackedScene
export var bulletImpact : PackedScene

const speed = 400
var direction = Vector2.ZERO

var parent = ''


# Called when the node enters the scene tree for the first time.
func _ready():
	if parent == "mobs":
		set_collision_layer_bit(256, true)
		set_collision_mask_bit(0, true)
		set_collision_mask_bit(1, false)
		set_collision_mask_bit(2, true)
	else:
		set_collision_layer_bit(256, true)
		set_collision_mask_bit(0, true)
		set_collision_mask_bit(1, true)


func _process(delta):

	var collisionResult = move_and_collide(direction * speed * delta)
	if collisionResult != null:
		
		#Get group at collision
		if collisionResult.collider.is_in_group("mobs"):
			var current_hp = collisionResult.collider.get('hp')
			collisionResult.collider.set('hp', current_hp-10)
		
		if collisionResult.collider.is_in_group("player"):
			var current_hp = collisionResult.collider.get('hp')
			collisionResult.collider.set('hp', current_hp-10)
		
		
		
		var smoke = smokeScene.instance() as Particles2D
		get_parent().add_child(smoke)
		smoke.global_position = collisionResult.position
		smoke.rotation = collisionResult.normal.angle()
		
		var impact = bulletImpact.instance() as Node2D
		get_parent().add_child(impact)
		impact.global_position = collisionResult.position
		impact.rotation = collisionResult.normal.angle()
		queue_free()
		
#func _on_Bullet_body_entered(body):
#	if body.is_in_group("enemy"):
#		body.hp -= 10
#		queue_free()
