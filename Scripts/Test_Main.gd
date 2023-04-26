extends Node
export var path: String
export var parent_path : NodePath
var parent 

# Var to make gen easier

""""
var x = 0
var R27n = "res://Scenes/Rooms/13x13R.tscn"


# Declare member variables here. Examples:
# var a = 2
var room_unit = 448


# Called when the node enters the scene tree for the first time.
func _ready():
	
	## Loads in Rooms
	if parent_path:
		parent = get_node(parent_path)
		LoadInstance("Spawn", Vector2(0,0))
		LoadInstance("Left_Bottom_Enter", Vector2(0, -1*room_unit))
		LoadInstance("Left_Right_Enter", Vector2(-1*room_unit,-1*room_unit))
		LoadInstance("All_Enter", Vector2(-2*room_unit, -1*room_unit))
		LoadInstance("Left_Right_Enter", Vector2(-3*room_unit,-1*room_unit))
		LoadInstance("Left_Right_Enter", Vector2(-4*room_unit,-1*room_unit))
		LoadInstance("Left_Right_Enter", Vector2(-5*room_unit,-1*room_unit))
		LoadInstance("Bottom_Enter", Vector2(-2*room_unit, -2*room_unit))
		LoadInstance("Top_Enter", Vector2(-2*room_unit, 0))
		LoadInstance("Right_Enter", Vector2(-6*room_unit, -1*room_unit))
		#LoadInstance(R27n, 2, Vector2(0,-1* room_unit), 0)
		#LoadInstance(R27n, 1, Vector2(0,-2*room_unit), 0 )
		#LoadInstance(R27n, 3, Vector2(0,-3*room_unit), 0)

func LoadInstance(path, newPos):
	path = "res://Scenes/Rooms/" + path + ".tscn"
	var room = load(path)
	var instance = room.instance()
	instance.set_position(newPos)
	parent.add_child(instance)
 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
"""


