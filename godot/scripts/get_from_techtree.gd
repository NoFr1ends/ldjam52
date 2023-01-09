extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var techtree : Node

# Called when the node enters the scene tree for the first time.
func _ready():
	techtree = get_node("%TechTree")
