extends "res://Scripts/Enemy.gd"
export var bulletScene: PackedScene
var shootRange = [0, 400]
var goodRange = [200, 400]
var bullet_speed = 300
var detectorID: Node
var randdrop = RandomNumberGenerator.new()
var healthDrop = preload("res://Scenes/Health_Pickup.tscn").instance()
## UI Variables



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize() # Seeding random drops
	setlayers() # Sets Collision Layers
	## Enemy Variables
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
	if detectorID == player.detectorID:
		move_to_player(goodRange[1], goodRange[0], get_player_pos(detectorID))
		move_and_slide(velocity)
	if health.health <= 0: # if killed, die
		healthdrop()
		queue_free()
	#var dx = self.global_position.x-get_player_pos(detectorID).x
	#var dy = self.global_position.y-get_player_pos(detectorID).y
	#var dist = sqrt((dx*dx)+(dy*dy))
	var dist = distance(get_player_pos(detectorID))
	#print("Distance:",dist)
	if detectorID == player.detectorID:
		if dist > shootRange[0] and dist < shootRange[1]:
			if hit_count >= hit_timer:
				shoot()
				hit_count = 0

	hit_count += 1


func healthdrop():
	randdrop.randomize()
	var healthdropchance = randdrop.randf_range(0,1)
	print(healthdropchance)
	if healthdropchance > 0.6:
		get_parent().add_child(healthDrop)
		healthDrop.position = self.position

func _on_RoomDetector_area_entered(area):
	detectorID = area
