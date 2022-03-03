extends KinematicBody2D


export var speed = 50
var velocity = Vector2.ZERO
var player = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = Vector2.ZERO
	if player:
		velocity = position.direction_to(player.position) * speed
	velocity = move_and_slide(velocity)


func _on_DetectArea_body_entered(body):
	player = body
	print("Player Found -- slow")


func _on_DetectArea_body_exited(body: Node) -> void:
	player = null
	print("Player Lost -- slow")
