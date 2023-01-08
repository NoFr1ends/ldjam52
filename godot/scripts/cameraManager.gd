extends Spatial

var cameraList = []

var camIdx = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	findByClass(get_tree().root, "Camera", cameraList)
	#for entry in cameraList:
	#	print_debug("camera: %s" % entry.name)

func _input(event):
	if event is InputEventKey and event.pressed and event.scancode == KEY_SPACE:
		camIdx += 1
		if camIdx >= cameraList.size(): camIdx = 0
		print_debug("camIdx: %s "% camIdx)
		cameraList[camIdx].current = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func findByClass(node: Node, className : String, result : Array) -> void:
	if node.is_class(className) :
		result.push_back(node)
	for child in node.get_children():
		findByClass(child, className, result)
