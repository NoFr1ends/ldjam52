extends Spatial

signal collected


export (float) var radius
export(float) var value
export (float) var coal_value = 0
export (PackedScene) var explosion

func _ready():
	pass # Replace with function body.


func _process(delta):
	pass


func explode(successful : bool):
	if explosion != null and successful:
		var newExplosion = explosion.instance()
		get_node("/root/Main").add_child(newExplosion)
		newExplosion.global_translation = global_translation
	queue_free()
