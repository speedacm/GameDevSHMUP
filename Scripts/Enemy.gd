extends KinematicBody2D

var speed: int
var velocity: Vector2 = Vector2.ZERO
onready var health: Node2D = $Health 
export (NodePath) var playerNodePath
onready var player = get_node(playerNodePath)
var hit_timer: int
var hit_count: int
var damage: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func get_player_pos():
	return player.position


func distance(player_pos: Vector2) -> float:
	var x_dist = position.x - player_pos.x
	var y_dist = position.y - player_pos.y
	var dist = sqrt((x_dist*x_dist) + (y_dist*y_dist))
	return dist


func velocity_to_player() -> Vector2:
	var v = position.direction_to(get_player_pos()) * speed
	return v


func move_to_player(detect_rad: int, run_rad: int, player_pos: Vector2) -> void:
	var dist = distance(player_pos)
	if dist <= detect_rad and dist >= run_rad:
		velocity = velocity_to_player()
	elif dist < run_rad:
		velocity = -1*velocity_to_player()
	else:
		velocity = Vector2.ZERO


func hit_player(collisions) -> void:
	for i in collisions:
		var collisionResult = get_slide_collision(i)
		if collisionResult.collider.is_in_group("player") and hit_count >= hit_timer:
			collisionResult.collider.health.set_health(collisionResult.collider.health.get_health()-damage)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
