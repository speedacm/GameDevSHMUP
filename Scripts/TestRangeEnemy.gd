extends "res://Scripts/Enemy.gd"
export var bulletScene: PackedScene
var shootRange = [0, 400]
var goodRange = [200, 400]
var bullet_speed = 300

## UI Variables



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setlayers()
	player = get_node(playerNodePath)
	speed = 150
	hit_timer = 60
	hit_count = 0

func shoot():
	var bullet = bulletScene.instance() as Node2D
	bullet.set("parent", "mobs")
	get_parent().add_child(bullet)
	bullet.set_speed(bullet_speed)
	bullet.global_position = global_position
	bullet.direction = (player.position - bullet.global_position).normalized()
	bullet.rotation = bullet.direction.angle()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move_to_player(goodRange[1], goodRange[0], get_player_pos())
	move_and_slide(velocity)
	if health.health <= 0:
		queue_free()
	var dist = distance(get_player_pos())
	if dist > shootRange[0] and dist < shootRange[1]:
		if hit_count >= hit_timer:
			shoot()
			hit_count = 0

	hit_count += 1
	
	#Sets Collision Layers
func setlayers():
	
	## Exists on layer
	set_collision_layer_bit(layer.ENEMY, true)
	
	## Collide with layer
	set_collision_mask_bit(layer.WALLS, true)
	set_collision_mask_bit(layer.PLAYER, true)

