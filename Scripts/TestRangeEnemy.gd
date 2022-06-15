extends KinematicBody2D
export (PackedScene) var Bullet

export var speed = 150
var velocity = Vector2.ZERO
var player = null
var danger = false
var good = false
var hp = 50

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
		#shoot()
	velocity = move_and_slide(velocity)
	if hp <= 0:
		queue_free()

func shoot():
	var b = Bullet.instance()
##	add_child(b)
##	b.transform = $Muzzle.transform
	owner.add_child(b)
	b.transform = $Muzzle.global_transform


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
