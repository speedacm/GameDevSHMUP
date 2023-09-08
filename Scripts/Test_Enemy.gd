extends "res://Scripts/Enemy.gd"
var detectorID

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setlayers()
	speed = 50
	hit_timer = 90
	hit_count = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.

### Tracks player & attacks 

func _physics_process(delta):
	move_to_player(400, 0, get_player_pos(detectorID))
	if hit_count < hit_timer:
		set_velocity(-1*velocity)
		move_and_slide()
	else:
		set_velocity(velocity)
		move_and_slide()
	var hits = []
	for i in get_slide_collision_count():
		hits.append(get_slide_collision(i))
	if hit_count > hit_timer:
		hit_player(hits)
	if health.health <= 0:
		queue_free()
	hit_count += 1


func _on_RoomDetector_area_entered(area):
	detectorID = area
