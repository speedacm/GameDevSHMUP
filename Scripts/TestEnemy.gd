extends "res://Scripts/Enemy.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setlayers()
	player = get_node(playerNodePath)
	speed = 50
	hit_timer = 90
	hit_count = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.

### Tracks player & attacks 

func _physics_process(delta):
	move_to_player(400, 0, get_player_pos())
	if hit_count < hit_timer:
		move_and_slide(-1*velocity)
	else:
		move_and_slide(velocity)
	var hits = []
	for i in get_slide_count():
		hits.append(get_slide_collision(i))
	if hit_count > hit_timer:
		hit_player(hits)
	if health.health <= 0:
		queue_free()
	hit_count += 1
	
func setlayers():
	# See wiki for collision layer key
	
	## Exists on layer
	set_collision_layer_bit(1, true)
	
	## Collide with layer
	set_collision_mask_bit(0, true)
	set_collision_mask_bit(2, true)
