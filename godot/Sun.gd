extends Node3D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
@onready var main = get_node("/root/Main")

@onready var sun = $Sun
@onready var moon = $Moon
@onready var world: WorldEnvironment = get_node("/root/Main/WorldEnvironment")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var t = main.time
	sun.rotation_degrees = Vector3(t * 360 + 180,0,0)
	moon.rotation_degrees = Vector3(t * 360,0,0)
	sun.visible = t < 0.5
	moon.visible = t > 0.5
	#world.environment.background_intensity = max(0,sin(t * 3.1415 * 2))
