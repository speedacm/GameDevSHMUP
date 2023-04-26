extends Node2D

var healamount = 10
signal heal(healamount)



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PickupArea_body_entered(body):
	if "Player" in body.name:
		body.health.set_health(body.health.health + healamount)
		queue_free()
	pass # Replace with function body.
