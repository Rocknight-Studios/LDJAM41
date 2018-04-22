extends Button

func _on_RestartButton_button_down():
	Global.attempts = 3
	Global.current_dialogue_index = 0
	Global.emit_signal("load_novel_scene")
