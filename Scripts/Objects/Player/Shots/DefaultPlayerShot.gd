extends KinematicBody2D

var speed = 25
var direction = Vector2(0, -1) 
var velocity = Vector2()

func _ready():
	rotation = direction.rotated(deg2rad(90)).angle()

func _process(delta):
	rotation = direction.rotated(deg2rad(90)).angle()
	velocity = speed * direction
	move_and_collide(velocity)
	
	if position.y <= 0:
		queue_free()