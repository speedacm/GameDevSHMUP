extends Position2D

onready var timer = get_node("TextTimer")
onready var label = get_node("Label")

var showtime = 0.5


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start(showtime)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_text(newtext):
	
	label.text = newtext 
	

func _on_TextTimer_timeout():
	# Could add a disappear effect here like smoke or otherwise
	queue_free()

func place(positionarg):
	var result = rand_range(1,1.09) * positionarg
	return result

#func random_point_inside_unit_circle():
#	var random_vector = Vector2(rand_range(-1, 1), rand_range(-1, 1))
#	random_vector = random_vector
#	random_vector *= rand_range(0, 1)
#	return random_vector
	
