extends KinematicBody2D

const NORMAL_SPEED = 5
const FOCUS_SPEED = 1.5

var speed = 0
var direction = Vector2()
var velocity = Vector2()
var parent
var shot_timer
var shot = preload("res://Scenes/Objects/Player/Shots/DefaultPlayerShot.tscn")
var can_shot = true
var hitbox

var graze = 0
var graze_radius = 10

func _ready():
	parent = get_parent()
	hitbox = $Hitbox
	shot_timer = $Timer

func _process(delta):
	var left = Input.is_action_pressed("left")
	var right = Input.is_action_pressed("right")
	var up = Input.is_action_pressed("up")
	var down = Input.is_action_pressed("down")
	var shift = Input.is_action_pressed("shift")
	var fire = Input.is_action_pressed("fire")
	direction = Vector2(0, 0)
	if left:
		direction += Vector2(-1, 0)
	if right:
		direction += Vector2(1, 0)
	if up:
		direction += Vector2(0, -1)
	if down:
		direction += Vector2(0, 1)
	direction = direction.normalized()

	if shift:
		speed = FOCUS_SPEED
	else:
		speed = NORMAL_SPEED

	if fire and can_shot:
		_shoot(Vector2(6,0))
		_shoot(Vector2(-6,0))
		_shoot(Vector2(18,0))
		_shoot(Vector2(-18,0))
		shot_timer.start()
		can_shot = false
		is_dead = false

	velocity = direction * speed

	move_and_collide(velocity)

func _shoot(pos=Vector2(0, 0), shotdir = Vector2(0, -1)):
	var shot_instance = shot.instance()
	shot_instance.position = position + pos
	shot_instance.direction = shotdir
	shot_instance.set_as_toplevel(true)
	add_child(shot_instance)

func _on_Timer_timeout():
	can_shot = true


onready var scene_load_timer = Timer.new() # To save resources and have just one instance of the timer.

func on_custom_collision(bullet):
	print(str(bullet) + " killed me.")
	is_dead = true
	$Death.play()

	scene_load_timer.set_one_shot(true)
	scene_load_timer.set_timer_process_mode(Timer.TIMER_PROCESS_PHYSICS)
	scene_load_timer.set_wait_time(1.0)
	scene_load_timer.connect("timeout", self, "on_load_novel_scene")
	scene_load_timer.start()
	add_child(scene_load_timer)

func on_load_novel_scene():
	Global.attempts -= 1
	Global.current_dialogue_index = 0
	if Global.attempts > 0:
		Global.emit_signal("load_novel_scene")
	else:
		Global.emit_signal("load_game_over_scene")

func on_graze_collision(bullet):
	print(str(bullet) + " grazed.")
	graze += 1
	print(str(graze))
	$Graze.play()

const custom_collision_layer = 0
var is_dead = false

