extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
@export var target : NodePath
@export var speed : float
var t = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t += delta * speed
	var tar = get_node(target)
	tar.rotation_degrees.x = t
