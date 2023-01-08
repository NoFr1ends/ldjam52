extends Spatial

signal collected


export (float) var radius
export(float) var value

func _ready():
	pass # Replace with function body.


func _process(delta):
	pass


func explode(successful : bool):
	queue_free()
