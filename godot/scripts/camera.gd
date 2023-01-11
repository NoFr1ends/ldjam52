extends Camera3D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
@onready var mount = $"../bagger/ctrl_base/ctrl_camera_mount"

# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("reparent2")
	
func reparent2():
	var global_pos = self.global_position
	var local_pos = mount.to_local(global_pos)
	get_parent().remove_child(self)
	mount.add_child(self)
	self.position = local_pos
	#get_node("/root/Main/CameraManager").cameraList[0] = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
