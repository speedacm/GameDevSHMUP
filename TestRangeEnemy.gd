extends KinematicBody2D


export var speed = 150
var velocity = Vector2.ZERO
var player = null
var danger = false
var good = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = Vector2.ZERO
	if player:
		velocity = position.direction_to(player.position) * speed
	if danger:
		velocity = -velocity
	elif good:
		velocity.x = 0
		velocity.y = 0
	velocity = move_and_slide(velocity)


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
