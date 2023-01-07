extends MeshInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player  = get_node("/root/Main/Player/bagger")

var hasSpawned := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	if hasSpawned: return	
	var pPos = player.global_translation
	var myPos = self.global_translation
	var myScale = self.scale
	
	# achtung: Plane-scale-y ist 3D-z
	if pPos.x < myPos.x + myScale.x / 2 and pPos.x > myPos.x - myScale.x / 2 and pPos.z < myPos.z + myScale.y / 2 and pPos.z > myPos.z - myScale.y / 2: 
	
		var shift = Vector3(-myScale.x,0,-myScale.y)
		
		for i in range(3):
			var newGround = get_parent().ground.instance()
			get_parent().add_child(newGround)
			newGround.global_translation = global_translation + shift
			shift += Vector3(myScale.x,0,0)
			
		print_debug("spawned new ground elements")
		hasSpawned = true
