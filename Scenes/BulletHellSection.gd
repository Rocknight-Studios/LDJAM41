extends Node

var viewport = null
var view = null

func _ready():
	viewport = get_node("Viewport")
	view = get_node("ViewportTexture")
	
	viewport.set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
	
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	view.texture = viewport.get_texture()

