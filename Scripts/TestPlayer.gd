extends KinematicBody2D
class_name TestPlayer

export var bulletScene : PackedScene

## Player Variables
export var speed = 200
var velocity = Vector2.ZERO
var direction

onready var health = $Health


### Player Movement Controls

func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('right'):
		velocity.x += 1
		direction = "right"
	if Input.is_action_pressed('left'):
		velocity.x -= 1
		direction = "left"
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	
	
### Shooting Function

func _unhandled_input(event):
	if (event.is_action_pressed("shoot")):
		var bullet = bulletScene.instance() as Node2D
		bullet.set('parent', 'player')
		get_parent().add_child(bullet)
		bullet.global_position = $GunModel/muzzle.global_position
		bullet.direction = (get_global_mouse_position() - global_position).normalized()
		bullet.rotation = bullet.direction.angle()


### Check if Dead
func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)
	if health.health <= 0:
		queue_free()
	
### i forgor what this is
func _process(_delta):
	flip()
	pass
	

# Flips player and gun when looking in a different direction
func flip():
	var flip = sign(get_global_mouse_position().x - $TestSprite.global_position.x)
	if flip < 0:
		$TestSprite.set_flip_h(true)
		$GunModel.set_flip_v(true)
	else:
		$TestSprite.set_flip_h(false)
		$GunModel.set_flip_v(false)

