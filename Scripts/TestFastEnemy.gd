extends KinematicBody2D


export var speed = 100
var velocity = Vector2.ZERO
var player = null
onready var health = $Health
var hit_timer = 30

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = Vector2.ZERO
	if player:
		velocity = position.direction_to(player.position) * speed
		look_at(player.position)
		if hit_timer < 30:
			velocity = -velocity
	velocity = move_and_slide(velocity)
	for i in get_slide_count():
		var collisionResult = get_slide_collision(i)
		if collisionResult.collider.is_in_group("player") and hit_timer >= 30:
			collisionResult.collider.health.set_health(collisionResult.collider.health.get_health()-10)
			hit_timer = 0
	if health.health <= 0:
		queue_free()
	hit_timer += 1


func _on_DetectArea_body_entered(body):
	player = body
	print("Player Found -- fast")


func _on_DetectArea_body_exited(body: Node) -> void:
	player = null
	print("Player Lost -- fast")
