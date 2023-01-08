extends Spatial

signal collected


export (float) var radius
export(float) var value
export (PackedScene) var explosion

func _ready():
	pass # Replace with function body.


func _process(delta):
	pass


func explode(successful : bool):
	if explosion != null:
		var newExplosion = explosion.instance()
		get_node("/root").get_child(0).add_child(newExplosion)
		newExplosion.global_translation = translation
	queue_free()
