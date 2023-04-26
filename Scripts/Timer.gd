extends Label

onready var 	 minutes = 0
onready var seconds = 0
onready var timer_string



func _ready():


	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Instructions_timer_start():
	$Timer.start()
	pass # Replace with function body.


func _on_Timer_timeout():
	seconds += 1
	if seconds == 60:
		minutes += 1
		seconds -= 60
		
	if seconds < 10:
		timer_string = "%s:0%s"
	else:
		timer_string = "%s:%s"
		
	self.text = timer_string % [minutes, seconds]
	pass # Replace with function body.
