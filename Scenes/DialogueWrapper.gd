extends Control

onready var girl_text = get_node("Background/GirlText") # For speed and convenience.
onready var button0 = get_node("Background/GirlText/VBoxContainer/Button0") # For speed and convenience.
onready var button1 = get_node("Background/GirlText/VBoxContainer/Button1") # For speed and convenience.
onready var button2 = get_node("Background/GirlText/VBoxContainer/Button2") # For speed and convenience.
onready var progress_bar = get_node("TextureProgress") # For speed and convenience.
export (Array) var dialogue_options = [] # All the options of the player.
var approximation_float = .0001 # Take floating point error into account.

func _ready():
	set_new_dialogue_state()

func set_new_dialogue_state():
	if dialogue_options[Global.current_dialogue_index][0] < 1.0 - approximation_float:
		girl_text.text = dialogue_options[Global.current_dialogue_index][4]
		button0.text = dialogue_options[Global.current_dialogue_index][1][0]
		button1.text = dialogue_options[Global.current_dialogue_index][2][0]
		button2.text = dialogue_options[Global.current_dialogue_index][3][0]

		progress_bar.value = dialogue_options[Global.current_dialogue_index][0]

		if progress_bar.value < approximation_float:
			Global.emit_signal("load_bullet_hell_scene")
	else:
		Global.emit_signal("load_victory_scene")

func _on_Button0_button_down():
	Global.current_dialogue_index = dialogue_options[Global.current_dialogue_index][1][1]
	set_new_dialogue_state()

func _on_Button1_button_down():
	Global.current_dialogue_index = dialogue_options[Global.current_dialogue_index][2][1]
	set_new_dialogue_state()

func _on_Button2_button_down():
	Global.current_dialogue_index = dialogue_options[Global.current_dialogue_index][3][1]
	set_new_dialogue_state()
