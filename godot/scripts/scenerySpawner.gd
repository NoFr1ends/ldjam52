extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (PackedScene) var scenery
export var count = 3
export var length = 100.0

var instances = []
onready var player = $"/root/Main/Player"

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0,count):
		var scene = scenery.instance()
		self.add_child(scene)
		scene.translation = Vector3(0,0,-i * length)
		instances.push_back(scene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for instance in instances:
		if instance.global_translation.z - player.global_translation.z  - length > 100.0:
			instance.global_translation.z -= length * count
