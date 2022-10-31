extends KinematicBody2D

var speed: int
var velocity: Vector2 = Vector2.ZERO
onready var health: Node2D = $Health 
export (NodePath) var playerNodePath
onready var player = get_node("/root/Scenes/TestMain/TestPlayer")
var hit_timer: int
var hit_count: int
var damage: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


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
	if dist <= detect_rad and dist >= run_rad+20:
		velocity = velocity_to_player()
	elif dist < run_rad:
		velocity = -1*velocity_to_player()
	else:
		velocity = Vector2.ZERO


func hit_player(hits) -> void:
	for hit in hits:
		if hit.collider.is_in_group("player"):
			hit.collider.health.set_health(hit.collider.health.get_health()-damage)
			hit_count = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
