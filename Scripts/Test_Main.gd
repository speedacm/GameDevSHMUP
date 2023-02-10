extends Node
export var path: String
export var parent_path : NodePath
var parent 

# Var to make gen easier
var x = 0
var R27n = "res://Scenes/Rooms/13x13R.tscn"


# Declare member variables here. Examples:
# var a = 2
var room_unit = 416


# Called when the node enters the scene tree for the first time.
func _ready():
	
	## Loads in Rooms
	if parent_path:
		parent = get_node(parent_path)
		LoadInstance(R27n, 0, Vector2(0,0), 0)
		LoadInstance(R27n, 2, Vector2(0,-1* room_unit), 0)
		LoadInstance(R27n, 1, Vector2(0,-2*room_unit), 0 )
		LoadInstance(R27n, 3, Vector2(0,-3*room_unit), 270)
		LoadInstance(R27n, 3, Vector2(1*room_unit,-3*room_unit), 90)
		LoadInstance(R27n, 5, Vector2(1*room_unit,-4*room_unit), 0)
		LoadInstance(R27n, 2, Vector2(-1*room_unit,-2*room_unit), 90)
		LoadInstance(R27n, 4, Vector2(-2*room_unit,-2*room_unit), 270)
		LoadInstance(R27n, 5, Vector2(-2*room_unit,-3*room_unit), 0)
		LoadInstance(R27n, 2, Vector2(-2*room_unit,-1*room_unit), 0)
		LoadInstance(R27n, 2, Vector2(-2*room_unit,0*room_unit), 0)
		LoadInstance(R27n, 3, Vector2(-2*room_unit,1*room_unit), 180)
		LoadInstance(R27n, 1, Vector2(-1*room_unit,1*room_unit), 0)
		LoadInstance(R27n, 5, Vector2(-1*room_unit,0*room_unit), 0)
		LoadInstance(R27n, 3, Vector2(-1*room_unit,2*room_unit), 180)
		LoadInstance(R27n, 2, Vector2(0*room_unit,1*room_unit), 90)
		LoadInstance(R27n, 3, Vector2(0*room_unit,2*room_unit), 0)
		LoadInstance(R27n, 2, Vector2(-2*room_unit,-1*room_unit), 0)
		LoadInstance(R27n, 1, Vector2(1*room_unit,1*room_unit), 0)
		LoadInstance(R27n, 3, Vector2(1*room_unit,0*room_unit), 270)
		LoadInstance(R27n, 4, Vector2(2*room_unit,0*room_unit), 90)
		LoadInstance(R27n, 3, Vector2(2*room_unit,1*room_unit), 90)
		LoadInstance(R27n, 2, Vector2(2*room_unit,-1*room_unit), 0)
		LoadInstance(R27n, 3, Vector2(2*room_unit,-2*room_unit), 0)
		LoadInstance(R27n, 2, Vector2(1*room_unit,-2*room_unit), 90)
		LoadInstance(R27n, 3, Vector2(0*room_unit,3*room_unit),180)
		LoadInstance(R27n, 1, Vector2(1*room_unit,3*room_unit), 0)
		LoadInstance(R27n, 5, Vector2(2*room_unit,3*room_unit), 90)
		LoadInstance(R27n, 2, Vector2(1*room_unit,4*room_unit), 0)
		LoadInstance(R27n, 5, Vector2(1*room_unit,5*room_unit), 180)
		LoadInstance(R27n, 2, Vector2(1*room_unit,2*room_unit), 0)

func LoadInstance(path, roomID, newPos, newRot):
	x=0 

	var rangeEnemy = load("res://Scenes/Repeat_Shot_Enemy.tscn")
	var rangeEnemyInstance = rangeEnemy.instance()
	var enemy = load("res://Scenes/Slime_Enemy.tscn")
	var enemyInstance = enemy.instance()
	enemyInstance.set_position(newPos)
	var repos = Vector2(newPos.x + 50, newPos.y+25)
	rangeEnemyInstance.set_position(repos)
	#fixer if statements 
	if newRot == 90:
		newPos = Vector2(newPos.x + 16*2, newPos.y)
	if newRot == 180:
		newPos = Vector2(newPos.x+ 16*2, newPos.y+16*2)
	if newRot == 270:
		newPos = Vector2(newPos.x, newPos.y+16*2)
	
	
	var scene = load(path);
	var instance = scene.instance();
	instance.set_position(newPos)
	instance.set_rotation_degrees(newRot)
	"""
	var collider = Area2D.new()
	var colliderShape = RectangleShape2D.new()
	colliderShape.extents = Vector2(215, 215)
	collider.add_child(colliderShape)
	collider.set_collision_layer_bit(11, true)
	instance.add_child(collider)
	"""
	parent.add_child(instance);
	#parent.add_child(enemyInstance)
	parent.add_child(rangeEnemyInstance)
	for i in instance.get_children():
		#print (i)
		if x != roomID:
			if x != 6:
				i.queue_free()
#			print("Room ID ", x, "is not in")
		x =x+1

 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
