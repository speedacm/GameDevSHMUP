extends "res://Scripts/TestRangeEnemy.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move_to_player(goodRange[1], goodRange[0], get_player_pos())
	move_and_slide(velocity)
	if health.health <= 0:
		queue_free()
	var shot = shoot(player, get_player_pos(), hit_count)
	if shot:
		hit_count = 0
	
	hit_count += 1
