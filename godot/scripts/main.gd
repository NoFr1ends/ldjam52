extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event is InputEventKey and event.is_pressed():
		match event.scancode: 
			KEY_F:
				OS.window_fullscreen = not OS.window_fullscreen
			KEY_M:
				$SoundOnOffButton.pressed = not $SoundOnOffButton.pressed
	
