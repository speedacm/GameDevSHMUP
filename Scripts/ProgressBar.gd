extends ProgressBar



# Called when the node enters the scene tree for the first time.
func _ready():
	value = max_value
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_Player_hphudupdate(new_health):
	value = new_health
	pass # Replace with function body.
