extends Node3D

signal collected


@export var radius: float
@export var value: float
@export var coal_value: float = 0
@export var explosion: PackedScene

func _ready():
	pass # Replace with function body.


func _process(delta):
	pass


func explode(successful : bool):
	if explosion != null and successful:
		var newExplosion = explosion.instantiate()
		get_node("/root/Main").add_child(newExplosion)
		newExplosion.global_position = global_position
	queue_free()
