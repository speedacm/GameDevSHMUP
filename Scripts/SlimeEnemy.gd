extends "res://Scripts/TestRangeEnemy.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = 50
	goodRange = [100, 200]


func shoot():
	var bullet_mid = bulletScene.instance() as Node2D
	var bullet_left = bulletScene.instance() as Node2D
	var bullet_right = bulletScene.instance() as Node2D
	bullet_mid.set_speed(200)
	bullet_left.set_speed(200)
	bullet_right.set_speed(200)
	bullet_mid.set("parent", "mobs")
	bullet_left.set("parent", "mobs")
	bullet_right.set("parent", "mobs")
	get_parent().add_child(bullet_mid)
	get_parent().add_child(bullet_left)
	get_parent().add_child(bullet_right)
	bullet_mid.global_position = global_position
	bullet_mid.direction = (player.position - bullet_mid.global_position).normalized()
	bullet_mid.rotation = bullet_mid.direction.angle()
	bullet_left.global_position = global_position
	bullet_left.direction.x = cos(bullet_mid.rotation+0.2)
	bullet_left.direction.y = sin(bullet_mid.rotation+0.2)
	bullet_left.rotation = bullet_left.direction.angle()
	bullet_right.global_position = global_position
	bullet_right.direction.x = cos(bullet_mid.rotation-0.2)
	bullet_right.direction.y = sin(bullet_mid.rotation-0.2)
	bullet_right.rotation = bullet_left.direction.angle()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
