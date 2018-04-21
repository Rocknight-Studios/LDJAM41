extends Control

onready var girl_text = get_node("Background/GirlText") # For speed and convenience.
onready var button0 = get_node("Background/GirlText/VBoxContainer/Button0") # For speed and convenience.
onready var button1 = get_node("Background/GirlText/VBoxContainer/Button1") # For speed and convenience.
onready var button2 = get_node("Background/GirlText/VBoxContainer/Button2") # For speed and convenience.
export (Array) var dialogue_options = [] # All the options of the player.
export var current_dialogue_index = 0 # To start dialogue from here.

func _ready():
	set_new_texts()

func set_new_texts():
	girl_text.text = dialogue_options[current_dialogue_index][0]
	button0.text = dialogue_options[current_dialogue_index][1][0]
	button1.text = dialogue_options[current_dialogue_index][2][0]
	button2.text = dialogue_options[current_dialogue_index][3][0]

func _on_Button0_button_down():
	current_dialogue_index = dialogue_options[current_dialogue_index][1][1]
	set_new_texts()

func _on_Button1_button_down():
	current_dialogue_index = dialogue_options[current_dialogue_index][2][1]
	set_new_texts()

func _on_Button2_button_down():
	current_dialogue_index = dialogue_options[current_dialogue_index][3][1]
	set_new_texts()
