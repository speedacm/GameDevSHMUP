extends "res://Scripts/TestRangeEnemy.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = 50
	goodRange = [100, 200]


func shoot(player, player_pos, shoot_timer):
	var dist = distance(player_pos)
	if dist > shootRange[0] and dist < shootRange[1]:
		if shoot_timer >= hit_timer:
			var bullet_mid = bulletScene.instance() as Node2D
			bullet_mid.set("parent", "mobs")
			get_parent().add_child(bullet_mid)
			bullet_mid.global_position = global_position
			bullet_mid.direction = (player.position - bullet_mid.global_position).normalized()
			bullet_mid.rotation = bullet_mid.direction.angle()
			return true
	return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
