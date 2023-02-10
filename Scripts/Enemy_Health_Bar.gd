extends ProgressBar




# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Health_healthchangeenemy(new_health):
	visible = true
	value = new_health
	pass # Replace with function body.



