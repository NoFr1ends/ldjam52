extends AudioStreamPlayer


export (Array, AudioStream) var musicList

var listPos = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	stream = musicList[listPos]
	play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BackgroundMusic_finished():
	listPos += 1
	if listPos >= musicList.size(): listPos = 0
	stream = musicList[listPos]
	play()

