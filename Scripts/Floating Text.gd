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
	queue_free()
