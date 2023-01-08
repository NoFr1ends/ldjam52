extends Camera


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var mount = $"../bagger/ctrl_base/ctrl_camera_mount"

# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("reparent")
	
	
	
	
func reparent():
	var global_pos = self.global_translation
	var local_pos = mount.to_local(global_pos)
	get_parent().remove_child(self)
	mount.add_child(self)
	self.translation = local_pos
	#get_node("/root/Main/CameraManager").cameraList[0] = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
