extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
@export var wiggleRefs: Array[NodePath]
var t = 0.0

@export var noise = FastNoiseLite.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	noise.seed = randi()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t += delta
	var i = 0
	for wiggleRef in wiggleRefs:
		i += 1
		var wiggleTarget = get_node(wiggleRef)
		if wiggleTarget == null:
			continue
		wiggleTarget.rotation_degrees.x = noise.get_noise_2d(t,i)
		wiggleTarget.rotation_degrees.y = noise.get_noise_2d(t,i+324)
		wiggleTarget.rotation_degrees.z = noise.get_noise_2d(t,i+123)
