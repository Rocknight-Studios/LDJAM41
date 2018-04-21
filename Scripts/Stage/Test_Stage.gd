extends "res://Scripts/Stage/Stage.gd"

var spawno
var spawno1
var spawno1posadd = 5
var spawno2
var spawno3
var spawno_custom_bullet_list = []
var spawno_custom_bullet_dic = {}
var timer = 0
var angle_list = [0.0]
var pos_list = [Vector2(192.0, 242.0)]

func _ready():	
	if section == 0:
		borders = [Vector2(-50, -50), Vector2(690, 500)]
		spawno1 = _create_spawner()
		spawno1.pos = Vector2(0, 480/4)
		spawno1.spin = 1
		spawno1.bullet_type = 1
		spawno1.bullet_speed = 3
		spawno1.spawnrate = 0.25
		spawno1.bullet_gravity = 0.05
		spawno1.bullet_ammount = 10
		spawno1.bullet_seperation = 360 - 36
		spawno2 = _create_spawner()
		spawno2.pos = Vector2(640, 480/4)
		spawno2.spin = -1
		spawno2.bullettype = 1
		spawno2.bullet_speed = 3
		spawno2.spawnrate = 0.25
		spawno2.bullet_gravity = 0.05
		spawno2.bullet_ammount = 10
		spawno2.bullet_seperation = 360 - 36
	if section == 1:
		borders = [Vector2(-100, -100), Vector2(484, 584)]
		bullet_lists.append(spawno_custom_bullet_list)
		spawno = _create_spawner()
		spawno.pos = Vector2(384/2, 484/4)
		spawno.spin = 0
		spawno.bullet_type = 1
		spawno.angle = 22.5
		spawno.bullet_speed = 3.0
		spawno.bullet_speed_to = 12.0
		spawno.bullet_acceleration = -0.1
		spawno.bullet_speed_to_enable = true
		spawno.spawnrate = 0.5
		spawno.bullet_ammount = 15.0
		spawno.threads = 8
		spawno.thread_seperation = 45
		spawno.bullet_list_to = spawno_custom_bullet_list
	if section == 2:
		borders = [Vector2(-100, -100), Vector2(484, 584)]
		bullet_lists.append(spawno_custom_bullet_list)
		spawno = _create_spawner()
		spawno.pos = Vector2(384/2, 484/2)
		spawno.angle = 22.5
		spawno.spin = 0.1
		spawno.bullet_type = 1
		spawno.angle = 0
		spawno.bullet_speed = 0.0
		spawno.bullet_acceleration = 0
		spawno.spawnrate = 0.2
		spawno.bullet_ammount = 8
		spawno.bullet_seperation = 360.0 - 45
		spawno.bullet_spawnradius = target(spawno.pos, player.position, 2).length()
		spawno.bullet_angle = 90
	if section == 3:
		borders = [Vector2(-100, -100), Vector2(484, 584)]
		bullet_lists.append(spawno_custom_bullet_list)
		spawno = _create_spawner()
		spawno.pos = Vector2(384/2, 484/2)
		spawno.angle = 22.5
		spawno.spin = 0.4
		spawno.bullet_type = 1
		spawno.angle = 0
		spawno.bullet_speed = 0.0
		spawno.bullet_dir_change = 0.00316
		spawno.bullet_acceleration = 0.02
		spawno.spawnrate = 0.1
		spawno.bullet_ammount = 4
		spawno.bullet_seperation = 0
		spawno.bullet_angle = -90
		spawno.bullet_spawnradius = 25
		spawno.bullet_spawnradius_to = 375
		spawno.bullet_spawnradius_to_enable = true
		spawno.threads = 4
		spawno.thread_seperation = 90
		#spawno1 = _create_spawner()
		#spawno1.pos = Vector2(384/2, 484/2)
		#spawno1.angle = target(spawno1.pos, player.position)
		#spawno1.spin = 0
		#spawno1.bullet_type = 0
		#spawno1.angle = 0
		#spawno1.bullet_speed = 2
		#spawno1.spawnrate = 0.5
		#spawno1.bullet_ammount = 10
		#spawno1.bullet_seperation = 360 - 36

func _process(delta):
	if section == 0:
		spawno1.pos.x += spawno1posadd
		spawno2.pos.x -= spawno1posadd
		if spawno1.pos.x >= 640:
			spawno1posadd = -5
		if spawno1.pos.x <= 0:
			spawno1posadd = 5
	if section == 1:
		spawno.angle = rand_range(16.875, 28.125)
		for b in spawno_custom_bullet_list:
			if b.speed <= 0:
				b.speed = -b.speed
				b.acceleration = 0.1
				b.max_speed = rand_range(2.0, 3.0)
				b.max_speed_enable = true
				b.dir = b.dir.rotated(deg2rad(180.0 + rand_range(-45, 45)))
				b.bullet_angle = -90
	if section == 2:
		spawno.bullet_spawnradius = target(spawno.pos, player.position, 2).length()
	if section == 3:
		#spawno1.angle = target(spawno1.pos, player.position)
		if timer > 30:
			for i in range(0, 7):
				var b_pos = Vector2(rand_range(162, 222), rand_range(212, 272))
				_create_bullet(b_pos, 0.25, rand_range(0, 360), 0)
			timer = 0
		else:
			timer += 1

		
