extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		(child.get_child(1) as AnimationPlayer).seek(rng.randf_range(0, 4), true)
		(child.get_child(1) as AnimationPlayer).playback_speed= rng.randf_range(.7, 1.1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
