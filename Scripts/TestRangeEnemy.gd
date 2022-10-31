extends "res://Scripts/Enemy.gd"
export var bulletScene: PackedScene
var shootRange = [0, 400]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node(playerNodePath)
	speed = 150
	hit_timer = 60
	hit_count = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move_to_player(400, 200, get_player_pos())
	move_and_slide(velocity)
	if health.health <= 0:
		queue_free()
	var shot = shoot(player, get_player_pos(), hit_count)
	if shot:
		hit_count = 0
	
	hit_count += 1


func shoot(player, player_pos, shoot_timer):
	var dist = distance(player_pos)
	if dist > shootRange[0] and dist < shootRange[1]:
		if shoot_timer >= hit_timer:
			var bullet = bulletScene.instance() as Node2D
			bullet.set("parent", "mobs")
			get_parent().add_child(bullet)
			bullet.global_position = global_position
			bullet.direction = (player.position - bullet.global_position).normalized()
			bullet.rotation = bullet.direction.angle()
			return true
	return false
