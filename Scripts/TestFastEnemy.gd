extends "res://Scripts/Enemy.gd"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node(playerNodePath)
	speed = 150
	hit_timer = 30
	hit_count = 0
	damage = 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
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
