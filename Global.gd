extends Node

signal load_bullet_hell_scene
signal load_novel_scene
signal load_victory_scene
signal load_game_over_scene

export var bullet_hell_scene_path = "res://Scenes/World.tscn" # To know, what to load.
export var novel_scene_path = "res://Scenes/Control.tscn" # To know, what to load.
export var victory_scene_path = "res://Scenes/Victory.tscn" # To know, what to load.
export var game_over_scene_path = "res://Scenes/GameOver.tscn" # To know, what to load.

export (int) var section = 0

export var current_dialogue_index = 0 # To start dialogue from here.

export var attempts = 3 # When there are no more attempts, load game over.

var current_scene = null

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child( root.get_child_count() -1 )
	connect("load_bullet_hell_scene", self, "on_load_bullet_hell_scene")
	connect("load_novel_scene", self, "on_load_novel_scene")
	connect("load_victory_scene", self, "on_load_victory_scene")
	connect("load_game_over_scene", self, "on_load_game_over_scene")

func on_load_bullet_hell_scene():
	goto_scene(bullet_hell_scene_path)

func on_load_novel_scene():
	goto_scene(novel_scene_path)

func on_load_victory_scene():
	goto_scene(victory_scene_path)

func on_load_game_over_scene():
	goto_scene(game_over_scene_path)

func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	current_scene.free()
	var s = ResourceLoader.load(path)
	current_scene = s.instance()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene( current_scene )

func _process(delta):
	print(current_dialogue_index)

