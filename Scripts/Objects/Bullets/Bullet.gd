extends Area2D

var max_speed = 0
var max_speed_enable = false
var min_speed = 0
var min_speed_enable = false
var acceleration = 0
var speed = 0
var grav = 0
var grav_vec = Vector2(0, 0)

var dir = Vector2()
var dir_change = 0
var dir_change_adder = 0

export (bool) var SPRITE_ANGLE = false

var velocity = Vector2()

func _ready():
	dir_change = deg2rad(dir_change)
	if SPRITE_ANGLE:
		rotation = dir.rotated(90).angle()

func _physics_process(delta):
	
	velocity = dir * speed + grav_vec
	position += velocity
	
	if max_speed_enable and speed >= max_speed:
		speed = max_speed
	elif min_speed_enable and speed <= min_speed:
		speed = min_speed
	else:
		speed += acceleration
	
	dir = dir.rotated(dir_change)
	dir_change += dir_change_adder
	
	grav_vec.y += grav
	
	if SPRITE_ANGLE:
		rotation = velocity.normalized().rotated(deg2rad(90)).angle()
	
	if position.x <= get_parent().borders[0].x or position.y <= get_parent().borders[0].y or position.x >= get_parent().borders[1].x or position.y >= get_parent().borders[1].y:
		queue_free()