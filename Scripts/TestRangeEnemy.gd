extends "res://Scripts/Enemy.gd"
export var bulletScene: PackedScene
var shootRange = [50, 100]

""""
export var speed = 150
var velocity = Vector2.ZERO
onready var player = null
var danger = false
var good = false
onready var health = $Health
var shootTimer = 0
"""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node(playerNodePath)
	speed = 150
	hit_timer = 60
	hit_count = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move_to_player(100, 20, get_player_pos())
	move_and_slide(velocity)
	"""
	velocity = Vector2.ZERO
	if player:
		velocity = position.direction_to(player.position) * speed
		look_at(player.position)
	if danger:
		velocity = -velocity
		look_at(player.position)
	elif good:
		velocity.x = 0
		velocity.y = 0
		look_at(player.position)
		if shootTimer >= 60:
			shoot(player)
			shootTimer = 0
	velocity = move_and_slide(velocity)
	if health.health <= 0:
		queue_free()
	shootTimer += 1
	"""

func shoot(player, player_pos):
	var dist = distance(player_pos)
	if dist > shootRange[0] and dist > shootRange[1]:
		var bullet = bulletScene.instance() as Node2D
		bullet.set("parent", "mobs")
		get_parent().add_child(bullet)
		bullet.global_position = global_position
		bullet.direction = (player.position - bullet.global_position).normalized()
		bullet.rotation = bullet.direction.angle()

"""
func _on_DetectArea_body_entered(body):
	player = body
	print("Player Found -- range")


func _on_DetectArea_body_exited(body: Node) -> void:
	player = null
	print("Player Lost -- ranged")


func _on_Danger_body_entered(body: Node) -> void:
	danger = true


func _on_Danger_body_exited(body: Node) -> void:
	danger = false


func _on_SafeZone_body_entered(body: Node) -> void:
	good = true


func _on_SafeZone_body_exited(body: Node) -> void:
	good = false
"""
