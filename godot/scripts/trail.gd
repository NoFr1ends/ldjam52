@tool 
extends MeshInstance3D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
@export var width = 1.0
@export var groundSize = 10
@export var depth = 1.0
@export var minVertexDistance = 10.0
@export var positions: Array[Vector3]
@export var baggerTranformPath : NodePath
@export var material: Material

var im_mesh = ImmediateMesh.new()

var baggerNode : Node3D
@onready var techtree = get_node("/root/Main/Control/TechTree")
# Called when the node enters the scene tree for the first time.
func _ready():
	mesh = im_mesh
	
	if not Engine.is_editor_hint():
		if not baggerTranformPath.is_empty():
			baggerNode = get_node(baggerTranformPath)
		baggerNode = get_node("/root/Main/Player/bagger/ctrl_base/ctrl_rotate/ctrl_height/ctrl_dig_pos")
		if baggerNode != null:
			print("node found")
	set_process(true)

func addQuad(a : Vector3,b : Vector3,c : Vector3,d : Vector3, ca : Color, cb : Color, cc : Color ,cd : Color):
	var dir1 = (b-a).normalized()
	var dir2 = (c-a).normalized()
	var normal = -dir1.cross(dir2).normalized()
	im_mesh.surface_set_normal(normal)
	# Triangle 1
	im_mesh.surface_set_uv(Vector2(a.x,a.z))
	im_mesh.surface_set_color(ca)
	im_mesh.surface_add_vertex(a)
	im_mesh.surface_set_uv(Vector2(b.x,b.z))
	im_mesh.surface_set_color(cb)
	im_mesh.surface_add_vertex(b)
	im_mesh.surface_set_uv(Vector2(c.x,c.z))
	im_mesh.surface_set_color(cc)
	im_mesh.surface_add_vertex(c)
	# Triangle 2
	im_mesh.surface_set_uv(Vector2(c.x,c.z))
	im_mesh.surface_set_color(cc)
	im_mesh.surface_add_vertex(c)
	im_mesh.surface_set_uv(Vector2(d.x,d.z))
	im_mesh.surface_set_color(cd)
	im_mesh.surface_add_vertex(d)
	im_mesh.surface_set_uv(Vector2(a.x,a.z))
	im_mesh.surface_set_color(ca)
	im_mesh.surface_add_vertex(a)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not Engine.is_editor_hint():
		if baggerNode != null:
			var newPos = to_local(baggerNode.global_position)
			newPos.y = 0
			if positions.size() < 2:
				positions = [Vector3(), Vector3()]
			var existing : Vector3 = positions[positions.size()-2]
			if existing.z -  newPos.z > minVertexDistance:
				positions.push_back(newPos)
			else:
				positions[positions.size()-1] = newPos
	
	var w = width
	if techtree != null:
		w = width * techtree.size_mult
		
	im_mesh.clear_surfaces()

	# Begin draw.
	im_mesh.surface_begin(Mesh.PRIMITIVE_TRIANGLES, material)
	var colGround = Color(0,1,0,1)
	var colTrail = Color(1,0,0,1)
	for i in range(0, positions.size()-1):
		var pos1 = positions[i]
		var pos2 = positions[i+1]
		addQuad(
			pos1 + Vector3( groundSize , 0,0),
			pos1 + Vector3( w         , 0,0),
			pos2 + Vector3( w          , 0,0),
			pos2 + Vector3( groundSize , 0,0),
			colGround, colGround, colGround, colGround)
		addQuad(
			pos1 + Vector3( w          , 0,0),
			pos1 + Vector3( w     * 0.8, -depth,0),
			pos2 + Vector3( w     * 0.8, -depth,0),
			pos2 + Vector3( w          , 0,0),
			colGround, colTrail, colTrail, colGround)
		addQuad(
			pos1 + Vector3(-w           , 0,0),
			pos1 + Vector3(- groundSize , 0,0),
			pos2 + Vector3(- groundSize , 0,0),
			pos2 + Vector3(-w           , 0,0),
			colGround, colGround, colGround, colGround)
		addQuad(
			pos1 + Vector3( -w     * 0.8, -depth,0),
			pos1 + Vector3( -w          , 0,0),
			pos2 + Vector3( -w          , 0,0),
			pos2 + Vector3( -w     * 0.8, -depth,0),
			colTrail, colGround, colGround, colTrail)
		addQuad(
			pos1 + Vector3( w     * 0.8, -depth,0),
			pos1 + Vector3(-w     * 0.8, -depth,0),
			pos2 + Vector3(-w     * 0.8, -depth,0),
			pos2 + Vector3( w     * 0.8, -depth,0),
			colTrail, colTrail, colTrail, colTrail)
	var pos = positions[positions.size()-1]
	addQuad(
		pos + Vector3( groundSize , 0,0),
		pos + Vector3(-groundSize , 0,0),
		pos + Vector3(-groundSize , 0,-groundSize),
		pos + Vector3( groundSize , 0,-groundSize),
		colGround, colGround, colGround, colGround)
	# End drawing.
	if positions.size() > 32:
		positions.pop_front()
	im_mesh.surface_end()
