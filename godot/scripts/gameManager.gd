extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.process_mode = PROCESS_MODE_ALWAYS
	var open_button = get_node("/root/Main/OpenTechTree")
	if open_button != null:
		open_button.connect("pressed",Callable(self,"_toggle_tech_tree"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _toggle_tech_tree():
	get_node("/root/Main/Control").visible = not get_node("/root/Main/Control").visible
	if get_node("/root/Main/Control").visible:
		get_tree().paused = true
	else:
		get_tree().paused = false

func _input(event):
	if event is InputEventKey and event.is_pressed():
		match event.keycode: 
			KEY_F:
				if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
					DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
				else:
					DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			KEY_M:
				get_node("/root/Main/SoundOnOffButton").button_pressed = not get_node("/root/Main/SoundOnOffButton").pressed
			KEY_P, KEY_PAUSE:
				get_tree().paused = not get_tree().paused
				if get_tree().paused:
					get_node("/root/Main/PausedOverlay").visible = true
				else:
					get_node("/root/Main/PausedOverlay").visible = false
			KEY_TAB:
				_toggle_tech_tree()
					
