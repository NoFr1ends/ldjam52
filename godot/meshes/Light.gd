extends SpotLight3D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

@onready var main = get_node("/root/Main")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var t = main.time
	self.visible = t > 0.5
