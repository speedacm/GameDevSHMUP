extends "res://Scripts/TestRangeEnemy.gd"

var shot_count = 0
var shot = false

# Called when the node enters the scene tree for the first time.
func _ready():
	setlayers()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move_to_player(goodRange[1], goodRange[0], get_player_pos())
	move_and_slide(velocity)
	if health.health <= 0:
		queue_free()
	var dist = distance(get_player_pos())
	if dist > shootRange[0] and dist < shootRange[1] and shot == false:
		if hit_count >= hit_timer:
			shot = true
			shot_count = 0
			hit_count = 0
	if shot:
		if shot_count == 0:
			shoot()
		elif shot_count == 10:
			shoot()
		elif shot_count == 20:
			shot = false
			shoot()
		hit_count = 0
		shot_count += 1
	hit_count += 1


func setlayers():
	
	## Exists on layer
	set_collision_layer_bit(layer.ENEMY, true)
	
	## Collide with layer
	set_collision_mask_bit(layer.WALLS, true)
	set_collision_mask_bit(layer.PLAYER, true)
