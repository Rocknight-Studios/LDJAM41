extends "res://Scripts/Stage/Stage.gd"

var spawno
var spawno1
var spawno1posadd = 5
var spawno2
var spawno3
var awesomeboss
var spawno_custom_bullet_list = []
var spawno_custom_bullet_dic = {}
var timer = 0
var angle_list = [0.0]
var pos_list = [Vector2(192.0, 242.0)]

func _ready():
	if section == 0:
		awesomeboss = _create_boss()
		awesomeboss.health = 500.0
		awesomeboss.max_health = 500.0
		awesomeboss.position = Vector2(384/2, 484/4)
		awesomeboss.connect("enemy_dead", self, "enemy_dead")
		spawno = _create_spawner()
		spawno.pos = Vector2(384/2, 484/4)
		spawno.bullet_ammount = 10
		spawno.spin = 2
		spawno.spawnrate = 0.015
		spawno.bullet_seperation = 324
		spawno.bullet_speed = 2
	if section == 1:
		awesomeboss = _create_boss()
		awesomeboss.health = 500.0
		awesomeboss.max_health = 500.0
		awesomeboss.position = Vector2(384/2, 484/4)
		awesomeboss.connect("enemy_dead", self, "enemy_dead")
		spawno = _create_spawner()
		spawno.pos = Vector2(384/2, 484/4)
		spawno.spawnrate = 0.01
		spawno.spin = 1.5
		spawno.angle = 100
		spawno.bullet_speed = 5.0
		spawno.bullet_ammount = 4
		spawno.bullet_seperation = 180
		spawno1 = _create_spawner()
		spawno1.pos = Vector2(384/2, 484/4)
		spawno1.spawnrate = 0.01
		spawno1.spin = -1.5
		spawno1.angle = -100
		spawno1.bullet_speed = 5.0
		spawno1.bullet_ammount = 4
		spawno1.bullet_seperation = 180

		spawno2 = _create_spawner()
		spawno2.pos = Vector2(384/2, 484/4)
		spawno2.spin = 0
		spawno2.bullet_spawnradius = 10
		spawno2.spawnrate = 0.5
		spawno2.bullet_ammount = 8.0
		spawno2.bullet_speed = 3.0
		spawno2.bullet_speed_to = 8.0
		spawno2.bullet_speed_to_enable = true
		spawno2.angle = target(spawno2.pos, player.position)
		spawno2.pause = true
	if section == 6:
		borders = [Vector2(-100, -100), Vector2(484, 584)]
		bullet_lists.append(spawno_custom_bullet_list)
		awesomeboss = _create_boss()
		awesomeboss.health = 500.0
		awesomeboss.max_health = 500.0
		awesomeboss.position = Vector2(384/2, 484/4)
		awesomeboss.connect("enemy_dead", self, "enemy_dead")
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
		spawno.bullet_ammount = 20.0
		spawno.threads = 8
		spawno.thread_seperation = 45
		spawno.bullet_list_to = spawno_custom_bullet_list
	if section == 7:
		borders = [Vector2(-100, -100), Vector2(484, 584)]
		bullet_lists.append(spawno_custom_bullet_list)
		awesomeboss = _create_boss()
		awesomeboss.health = 500.0
		awesomeboss.max_health = 500.0
		awesomeboss.position = Vector2(384/2, 484/2)
		awesomeboss.connect("enemy_dead", self, "enemy_dead")
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
	if section == 8:
		borders = [Vector2(-100, -100), Vector2(484, 584)]
		bullet_lists.append(spawno_custom_bullet_list)
		awesomeboss = _create_boss()
		awesomeboss.health = 1500.0
		awesomeboss.max_health = 1500.0
		awesomeboss.position = Vector2(384/2, 484/4)
		awesomeboss.connect("enemy_dead", self, "enemy_dead")
		spawno = _create_spawner()
		spawno.pos = Vector2(384/2, 484/4)
		spawno.angle = 22.5
		spawno.spin = 1
		spawno.bullet_type = 0
		spawno.angle = 0
		spawno.bullet_speed = 0.0
		spawno.bullet_acceleration = 0.005
		spawno.spawnrate = 0.05
		spawno.bullet_ammount = 20
		spawno.bullet_seperation = 360 -12
		spawno.bullet_spawnradius = 25

func _process(delta):
	if section == 0:
		if timer >= 7:
			spawno.bullet_speed = 2
			timer = 0
			spawno.angle += rand_range(0, 90)
			spawno.spin = rand_range(5, -5)
		spawno.bullet_speed += 0.425
		timer += 1
	if section == 1:
		if timer >= 60:
			spawno2.pause = false
		if spawno.angle >= 130:
			spawno.spin = -1.5
		if spawno.angle <= 95:
			spawno.spin = 1.5
		if spawno1.angle <= -130:
			spawno1.spin = 1.5
		if spawno1.angle >= -95:
			spawno1.spin = -1.5
		spawno2.angle = target(spawno2.pos, player.position)
		timer += 1
	if section == 6:
		spawno.angle = rand_range(16.875, 28.125)
		for b in spawno_custom_bullet_list:
			if b.speed <= 0:
				b.speed = -b.speed
				b.acceleration = 0.1
				b.max_speed = rand_range(1.5, 2.0)
				b.max_speed_enable = true
				b.dir = b.dir.rotated(deg2rad(180.0 + rand_range(-22.5, 22.5)))
				b.rotation = -90
	if section == 7:
		#spawno1.angle = target(spawno1.pos, player.position)
		if timer > 30:
			for i in range(0, 11):
				var b_pos = Vector2(rand_range(162, 222), rand_range(212, 272))
				_create_bullet(b_pos, 0.25, rand_range(0, 360), 0)
			timer = 0
		else:
			timer += 1
	if section == 8:
		spawno.bullet_angle = rand_range(-360, 360)
		spawno.pos.y += 0.02
		spawno.bullet_acceleration += 0.000015
		spawno.spawnrate += 0.000004

func enemy_dead():
	for i in bullet_lists:
		for b in i:
			b.free()
			i.remove(i.find(b))
	awesomeboss.queue_free()
	set_physics_process(false)
	scene_load_timer.set_one_shot(true)
	scene_load_timer.set_timer_process_mode(Timer.TIMER_PROCESS_PHYSICS)
	scene_load_timer.set_wait_time(1.0)
	scene_load_timer.connect("timeout", self, "on_load_novel_scene")
	scene_load_timer.start()
	add_child(scene_load_timer)
		
