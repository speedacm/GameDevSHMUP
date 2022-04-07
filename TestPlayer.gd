extends KinematicBody2D

export (PackedScene) var Bullet

export var speed = 200
var velocity = Vector2.ZERO
var shoot_timer = 60
var count = shoot_timer


func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	
	#if Input.is_action_just_pressed("shoot"):
	#	shoot()

func _physics_process(delta):
	look_at(get_global_mouse_position())
	get_input()
	if Input.is_action_pressed("shoot") and count >= shoot_timer:
		shoot()
		count = 0
	count += 1
	velocity = move_and_slide(velocity)


func shoot():
	var b = Bullet.instance()
	b.transform = $Muzzle.global_transform
	get_tree().get_root().add_child(b)
