extends KinematicBody2D

export var smokeScene : PackedScene
export var bulletImpact : PackedScene

const speed = 400
var direction = Vector2.ZERO



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	var collisionResult = move_and_collide(direction * speed * delta)
	if collisionResult != null:
		var smoke = smokeScene.instance() as Particles2D
		get_parent().add_child(smoke)
		smoke.global_position = collisionResult.position
		smoke.rotation = collisionResult.normal.angle()
		
		var impact = bulletImpact.instance() as Node2D
		get_parent().add_child(impact)
		impact.global_position = collisionResult.position
		impact.rotation = collisionResult.normal.angle()
		queue_free()
