extends Camera


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var mount = $"../bagger/ctrl_base/ctrl_rotate/Pillar"

# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("reparent")
	
	
	
	
func reparent():
	get_parent().remove_child(self)
	mount.add_child(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
