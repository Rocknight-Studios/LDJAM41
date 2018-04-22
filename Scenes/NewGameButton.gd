extends Button

func _ready():
	pass

func _on_NewGameButton_button_down():
	Global.emit_signal("load_novel_scene")
