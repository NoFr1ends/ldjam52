extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var destroy_delay = 8.0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Debris.restart()
	$Explosion.restart()
	$Smoke.restart()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	destroy_delay -= delta
	if destroy_delay < 0.0:
		queue_free()
