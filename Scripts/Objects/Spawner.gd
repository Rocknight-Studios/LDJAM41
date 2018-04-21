extends Node

var SHAPES = ["CIRCLE", "RECTANGLE", "TRIANGLE", "HEARTH"]

var pos = Vector2(0, 0)
var current_shape = SHAPES[0]
var shape_rotation = 0
var shape_spin = 0
var shape_scale = Vector2()
var angle = 0
var spin = 1
var spin_acc = 0
var threads = 1
var thread_seperation = 0
var thread_spawnradius = 0
var thread_spawnradius_to = 0
var thread_spawnradius_to_enable = false
var bullet_ammount = 1
var bullet_seperation = 0
var bullet_speed = 1
var bullet_speed_to = 0
var bullet_speed_to_enable = false
var bullet_type = 0
var bullet_acceleration = 0
var bullet_max_speed = 0
var bullet_max_speed_enable = false
var bullet_min_speed = 0
var bullet_min_speed_enable = false
var bullet_spawnradius = 0
var bullet_spawnradius_to = 0
var bullet_spawnradius_to_enable = false
var bullet_angle = 0
var bullet_angle_to = 0
var bullet_angle_to_enable = false
var bullet_angle_only = false
var bullet_target = Vector2(0,0)
var bullet_target_enable = false
var bullet_dir_change = 0
var bullet_dir_change_adder = 0
var bullet_gravity = 0
var spawnrate = 0
var spawnrate_timer
var shoot = true
var pause = false
var bullet_list_to
var parent

func _ready():
	parent = get_parent()
	if bullet_list_to == null:
		bullet_list_to = parent.default_bullet_list
	spawnrate_timer = $Spawnrate

func _on_Spawnrate_timeout():
	shoot = true

func shapelizer(e_dir, extra_angle):
	var f_dir = Vector2()
	if current_shape == SHAPES[0]:
		return e_dir
	elif current_shape == SHAPES[1]:
		e_dir = e_dir.rotated(deg2rad(-(shape_rotation + extra_angle)))
		if abs(e_dir.x) >= abs(e_dir.y):
			f_dir.x = 1 * sign(e_dir.x)
			f_dir.y = (abs(e_dir.y) + (1 - abs(e_dir.x))) * sign(e_dir.y)
			return f_dir.rotated(deg2rad((shape_rotation + extra_angle)))
		elif abs(e_dir.x) <= abs(e_dir.y):
			f_dir.y = 1 * sign(e_dir.y)
			f_dir.x = (abs(e_dir.x) + (1 - abs(e_dir.y))) * sign(e_dir.x)
			return f_dir.rotated(deg2rad((shape_rotation + extra_angle)))
	elif current_shape == SHAPES[2]:
		e_dir = e_dir.rotated(deg2rad(-(shape_rotation + extra_angle)))
		if abs(e_dir.y) >= abs(e_dir.x) and e_dir.y > 0:
			f_dir.y = 1
			f_dir.x = (abs(e_dir.x) + (1 - abs(e_dir.y))) * sign(e_dir.x)
			return f_dir.rotated(deg2rad((shape_rotation + extra_angle)))
		else:
			return e_dir
	elif current_shape == SHAPES[3]:
		e_dir = e_dir.rotated(deg2rad(-(shape_rotation + extra_angle)))
		if e_dir.y >= 0:
			e_dir = e_dir.rotated(deg2rad(90))
			if abs(e_dir.x) >= abs(e_dir.y):
				f_dir.x = 1 * sign(e_dir.x)
				f_dir.y = (abs(e_dir.y) + (1 - abs(e_dir.x))) * sign(e_dir.y)
				return f_dir.rotated(deg2rad((shape_rotation + extra_angle -90)))
			elif abs(e_dir.x) <= abs(e_dir.y):
				f_dir.y = 1 * sign(e_dir.y)
				f_dir.x = (abs(e_dir.x) + (1 - abs(e_dir.y))) * sign(e_dir.x)
				return f_dir.rotated(deg2rad((shape_rotation + extra_angle -90)))
		else:
			return e_dir.rotated(deg2rad((shape_rotation + extra_angle)))
	
func _process(delta):
	if !pause:
		if shoot:
			if bullet_ammount > 0 and threads > 0:
				for t in (threads):
					for b in (bullet_ammount):
						var b_angle
						var b_angle_true
						var b_dir
						var b_speed
						var b_pos
						if bullet_ammount == 1:
							b_angle = angle + (thread_seperation * t)
							b_dir = (Vector2(1,0).rotated(deg2rad(b_angle)))
							b_dir = shapelizer(b_dir, (thread_seperation * t))
							b_angle = rad2deg(b_dir.normalized().angle())
							b_speed = bullet_speed
							b_pos = pos + ((b_dir * bullet_spawnradius) + ((Vector2(1,0).rotated(deg2rad(angle+(thread_seperation*t)))) * thread_spawnradius))
						else:
							b_angle = angle + (thread_seperation * t) + ((bullet_seperation/(bullet_ammount-1)) * (b))
							b_dir = (Vector2(1,0).rotated(deg2rad(b_angle)))
							b_dir = shapelizer(b_dir, (thread_seperation * t))
							b_angle = rad2deg(b_dir.normalized().angle())
							
							if bullet_speed_to_enable:
								b_speed = bullet_speed + (((bullet_speed_to - bullet_speed)/(bullet_ammount-1)) * b)
							else:
								b_speed = bullet_speed
							if bullet_spawnradius_to_enable:
								if thread_spawnradius_to_enable:
									b_pos = pos + (b_dir * bullet_spawnradius) + ((((b_dir * bullet_spawnradius_to) - ((b_dir * bullet_spawnradius)))/bullet_ammount) * b ) + (Vector2(1,0).rotated(deg2rad(angle+(thread_seperation*t)))) + (((((Vector2(1,0).rotated(deg2rad(angle+(thread_seperation*t)))) * thread_spawnradius_to) - (((Vector2(1,0).rotated(deg2rad(angle+(thread_seperation*t)))) * thread_spawnradius)))/threads) * b )
								else:
									b_pos = pos + (b_dir * bullet_spawnradius) + ((((b_dir * bullet_spawnradius_to) - ((b_dir * bullet_spawnradius)))/bullet_ammount) * b ) + ((Vector2(1,0).rotated(deg2rad(angle+(thread_seperation*t)))) * thread_spawnradius)
							elif thread_spawnradius_to_enable:
								b_pos = pos + (b_dir * bullet_spawnradius) + (Vector2(1,0).rotated(deg2rad(angle+(thread_seperation*t)))) + (((((Vector2(1,0).rotated(deg2rad(angle+(thread_seperation*t)))) * thread_spawnradius_to) - (((Vector2(1,0).rotated(deg2rad(angle+(thread_seperation*t)))) * thread_spawnradius)))/threads) * b )
							else: 
								b_pos = pos + ((b_dir * bullet_spawnradius) + ((Vector2(1,0).rotated(deg2rad(angle+(thread_seperation*t)))) * thread_spawnradius))
						if bullet_angle_only:
							if bullet_angle_to_enable and bullet_ammount > 1:
								b_angle_true = bullet_angle + (((bullet_angle_to - bullet_angle)/(bullet_ammount-1)) * b)
							else:
								b_angle_true = bullet_angle
						elif bullet_target_enable:
							b_angle_true = parent.target(b_pos, bullet_target)
						else:
							if bullet_angle_to_enable and bullet_ammount > 1:
								b_angle_true = b_angle + bullet_angle + (((bullet_angle_to - bullet_angle)/(bullet_ammount-1)) * b)
							else:
								b_angle_true = b_angle + bullet_angle
						parent._create_bullet(b_pos, b_speed, b_angle_true, bullet_type, bullet_acceleration, bullet_max_speed, bullet_max_speed_enable, bullet_min_speed, bullet_min_speed_enable, bullet_dir_change, bullet_dir_change_adder, bullet_gravity, bullet_list_to)
				spawnrate_timer.wait_time = spawnrate
				shoot = false
				spawnrate_timer.start()
	else:
		spawnrate_timer.wait_time = 0
		
	angle += spin
	spin += spin_acc
	shape_rotation += shape_spin
