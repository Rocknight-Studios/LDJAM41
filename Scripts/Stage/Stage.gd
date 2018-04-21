extends Node2D

var borders = [Vector2(-100, -100), Vector2(484, 584)]
var bullet_types = [preload("res://Scenes/Objects/Bullets/Bullet.tscn"), preload("res://Scenes/Objects/Bullets/Bullet1.tscn"), preload("res://Scenes/Objects/Bullets/Bullet2.tscn")]
var bullet_tex_types = [preload("res://Resources/Sprites/Objects/Bullets/bullet.png"), preload("res://Resources/Sprites/Objects/Bullets/bullet1.png")]
var bullet_type_angle_allow = [false, true]
var bullet_lists = []
var bullet_shapes = []
var default_bullet_list = []
var spawner = preload("res://Scenes/Objects/Spawner.tscn")
var space_state
export (int) var section = 0

class Bullet extends Object:
	var max_speed = 0
	var radius = 10.0
	var pos = Vector2()
	var max_speed_enable = false
	var min_speed = 0
	var min_speed_enable = false
	var acceleration = 0
	var rotation = 0
	var speed = 0
	var grav = 0
	var grav_vec = Vector2(0, 0)

	var dir = Vector2()
	var dir_change = 0
	var dir_change_adder = 0

	var velocity = Vector2()

	var SPRITE_ANGLE = false
	var type = 0
	var hitbox = RID()

	func _process():

		velocity = dir * speed + grav_vec
		pos += velocity

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
			if speed != 0:
				rotation = velocity.normalized().rotated(deg2rad(90)).angle()
			if speed == 0:
				rotation = dir.rotated(deg2rad(90)).angle()

	func check_collisions(player, player_pos):
		 if player.custom_collision_layer == 0:
			 if player_pos.x > pos.x - radius && player_pos.x < pos.x + radius:
				 if player_pos.y > pos.y - radius && player_pos.y < pos.y + radius:
					 player.on_custom_collision(self)

func _create_bullet(pos, speed, angle, type = 0, acceleration = 0, max_speed = 0, max_speed_enable = false, min_speed = 0, min_speed_enable = false, dir_change = 0, dir_change_adder = 0, gravity = 0, bullet_list_to = default_bullet_list):
	var b = Bullet.new()
	b.speed = speed
	b.acceleration = acceleration
	b.max_speed = max_speed
	b.max_speed_enable = max_speed_enable
	b.min_speed = min_speed
	b.min_speed_enable = min_speed_enable
	b.dir = Vector2(1, 0).rotated(deg2rad(angle))
	b.dir_change = dir_change
	b.dir_change_adder = dir_change_adder
	b.pos = pos
	b.grav = gravity
	b.type = type
	b.SPRITE_ANGLE = bullet_type_angle_allow[type]
	b.rotation = b.dir.angle()

	b.hitbox = Physics2DServer.body_create()
	b.radius = 10.0

	bullet_list_to.append(b)

func _draw():
	for i in bullet_lists:
		for b in i:
			var bullet_width = bullet_tex_types[b.type].get_width()
			var bullet_height = bullet_tex_types[b.type].get_height()
			draw_set_transform(Vector2(round(b.pos.x), round(b.pos.y)), b.rotation, Vector2(1, 1))
			draw_texture(bullet_tex_types[b.type], Vector2(bullet_width/2.0, bullet_height/2.0) * -1)

var player = null # For speed and convenience.
var player_pos = null # For speed and convenience.

func _ready():
	player = get_parent().get_node("Player")
	bullet_lists.append(default_bullet_list)
	space_state = get_world_2d().space
	bullet_shapes.append(Physics2DServer.circle_shape_create())
	Physics2DServer.shape_set_data(bullet_shapes[0], 100)

func target(spawnpos, targetpos, returnvalue = 0):
	var finalpos = targetpos - spawnpos
	var finaldir = finalpos.normalized()
	if returnvalue == 0:
		var finalangle = rad2deg(finaldir.angle())
		return finalangle
	if returnvalue == 1:
		return finaldir
	if returnvalue == 2:
		return finalpos


func _create_spawner():
	var s = spawner.instance()
	add_child(s)
	return get_node(s.get_path())

func _process(delta):
	var bullet_on_screen = 0
	for i in bullet_lists:
		for b in i:
			bullet_on_screen += 1
			if b.pos.x <= borders[0].x or b.pos.y <= borders[0].y or b.pos.x >= borders[1].x or b.pos.y >= borders[1].y:
				b.free()
				i.remove(i.find(b))

func _physics_process(delta):
	var player_is_dead = player.is_dead # For speed and convenience.
	if !player_is_dead:
		player_pos = player.get_global_transform().origin
	for i in bullet_lists:
		for b in i:
			b._process()
			if !player_is_dead:
				b.check_collisions(player, player_pos)
	update()
