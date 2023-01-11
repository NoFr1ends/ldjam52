extends CheckButton


@onready var drivingSound = get_node("/root/Main/DrivingSound")
@onready var backgroundMusic = get_node("/root/Main/BackgroundMusic")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SoundOnOffButton_toggled(button_pressed):
	backgroundMusic.stream_paused = not button_pressed
	drivingSound.stream_paused = not button_pressed
