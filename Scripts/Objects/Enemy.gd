extends KinematicBody2D

var health = 0
var max_health = 0
var current_pos = Vector2()
var move_speed = 5
var target_pos = Vector2()
var target_dir = Vector2()
var pos_to_target_dir = Vector2()
var health_bar_scene = preload("res://Scenes/Objects/Health.tscn")
var health_bar = 0
signal enemy_dead

func _ready():
	self.show_behind_parent = true
	health_bar = health_bar_scene.instance()
	health_bar.value = 100
	health_bar.rect_position += self.position
	get_parent().add_child(health_bar)
	health_bar = get_node(health_bar.get_path())

func take_damage(damage):
	health -= damage
	if health <= 0:
		emit_signal("enemy_dead")
	health_bar.value = health/max_health * 100.0
	print(health)

func move(target_input_pos):
	current_pos = self.position
	target_pos = target_input_pos
	target_dir = (current_pos - target_pos).normalized()
	print(current_pos)
	print(target_pos)
	print(target_dir)
	set_process(true)

func _process(delta):
	pos_to_target_dir = (position - target_pos).normalized()
	print(pos_to_target_dir)
	print(target_dir)
	if pos_to_target_dir.angle() != target_dir.angle():
		set_process(false)
		return
	else:
		move_and_collide(move_speed * target_dir * 60 * delta)
