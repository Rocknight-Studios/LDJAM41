extends Node

signal load_bullet_hell_scene
signal load_novel_scene

export var bullet_hell_scene_path = "res://Scenes/World.tscn" # To know, what to load.
export var novel_scene_path = "res://Scenes/Control.tscn" # To know, what to load.
var current_scene = null

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child( root.get_child_count() -1 )
	connect("load_bullet_hell_scene", self, "on_load_bullet_hell_scene")
	connect("load_novel_scene", self, "on_load_novel_scene")

func on_load_bullet_hell_scene():
	goto_scene(bullet_hell_scene_path)

func on_load_novel_scene():
	goto_scene(novel_scene_path)

func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	current_scene.free()
	var s = ResourceLoader.load(path)
	current_scene = s.instance()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene( current_scene )

