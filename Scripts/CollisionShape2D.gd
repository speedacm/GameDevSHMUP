extends CollisionShape2D

signal newweapon(behavior)

var behavior = "mArrow"

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	print("Weapon Pickup")
	emit_signal("newweapon", behavior)
	queue_free()

