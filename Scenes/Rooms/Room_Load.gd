extends TileMap
@export var parent_node : NodePath

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var node = get_node(parent_node)
	self.set_position(node.get_position())
	self.set_rotation_degrees(node.get_rotation_degrees())
	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

