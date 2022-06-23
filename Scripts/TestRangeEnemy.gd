extends KinematicBody2D
export var bulletScene: PackedScene

export var speed = 150
var velocity = Vector2.ZERO
onready var player = null
var danger = false
var good = false
var hp = 50
var shootTimer = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
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
	if hp <= 0:
		queue_free()
	shootTimer += 1

func shoot(player):
	var bullet = bulletScene.instance() as Node2D
	get_parent().add_child(bullet)
	bullet.global_position = self.global_position
	bullet.direction = (player.position - global_position).normalized()
	bullet.rotation = bullet.direction.angle()


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
