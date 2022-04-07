extends Area2D

var shoot_timer = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_Gun_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		print("player hit")
		body.shoot_timer = shoot_timer
		queue_free()
