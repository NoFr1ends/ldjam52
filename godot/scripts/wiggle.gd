extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (Array, NodePath) var wiggleRefs
var t = 0.0

var noise = OpenSimplexNoise.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	noise.seed = randi()
	noise.octaves = 4
	noise.period = 1.0
	noise.persistence = 0.8


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t += delta
	var i = 0
	for wiggleRef in wiggleRefs:
		i += 1
		get_node(wiggleRef).rotation_degrees.x = noise.get_noise_2d(t,i)
		get_node(wiggleRef).rotation_degrees.y = noise.get_noise_2d(t,i+324)
		get_node(wiggleRef).rotation_degrees.z = noise.get_noise_2d(t,i+123)
