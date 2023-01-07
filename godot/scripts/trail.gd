tool 
extends ImmediateGeometry


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var width = 1.0
export var groundSize = 10
export var depth = 1.0
export var minVertexDistance = 10.0
export (Array, Vector3) var positions
export var baggerTranformPath : NodePath
var baggerNode : Spatial

# Called when the node enters the scene tree for the first time.
func _ready():
	if not Engine.editor_hint:
		if not baggerTranformPath.is_empty():
			baggerNode = get_node(baggerTranformPath)
		baggerNode = get_node("/root/Main/Player/bagger/ctrl_base/ctrl_rotate/ctrl_height/ctrl_dig_pos")
		if baggerNode != null:
			print("node found")
		
	set_process(true)

func addQuad(a : Vector3,b : Vector3,c : Vector3,d : Vector3,
			 ca : Color, cb : Color, cc : Color ,cd : Color):
	var dir1 = (b-a).normalized()
	var dir2 = (c-a).normalized()
	var normal = -dir1.cross(dir2).normalized()
	set_normal(normal)
	# Triangle 1
	set_uv(Vector2(a.x,a.z))
	set_color(ca)
	add_vertex(a)
	set_uv(Vector2(b.x,b.z))
	set_color(cb)
	add_vertex(b)
	set_uv(Vector2(c.x,c.z))
	set_color(cc)
	add_vertex(c)
	# Triangle 2
	set_uv(Vector2(c.x,c.z))
	set_color(cc)
	add_vertex(c)
	set_uv(Vector2(d.x,d.z))
	set_color(cd)
	add_vertex(d)
	set_uv(Vector2(a.x,a.z))
	set_color(ca)
	add_vertex(a)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not Engine.editor_hint:
		if baggerNode != null:
			var newPos = to_local(baggerNode.global_translation)
			newPos.y = 0
			if positions.size() < 2:
				positions = [Vector3(), Vector3()]
			var existing : Vector3 = positions[positions.size()-2]
			if existing.z -  newPos.z > minVertexDistance:
				positions.push_back(newPos)
			else:
				positions[positions.size()-1] = newPos
	
	# Clean up before drawing.
	clear()

	# Begin draw.
	begin(Mesh.PRIMITIVE_TRIANGLES)
	var colGround = Color(0,1,0,1)
	var colTrail = Color(1,0,0,1)
	for i in range(0, positions.size()-1):
		var pos1 = positions[i]
		var pos2 = positions[i+1]
		addQuad(
			pos1 + Vector3( groundSize , 0,0),
			pos1 + Vector3( width      , 0,0),
			pos2 + Vector3( width      , 0,0),
			pos2 + Vector3( groundSize , 0,0),
			colGround, colGround, colGround, colGround)
		addQuad(
			pos1 + Vector3( width      , 0,0),
			pos1 + Vector3( width * 0.8, -depth,0),
			pos2 + Vector3( width * 0.8, -depth,0),
			pos2 + Vector3( width      , 0,0),
			colGround, colTrail, colTrail, colGround)
		addQuad(
			pos1 + Vector3(-width       , 0,0),
			pos1 + Vector3(- groundSize , 0,0),
			pos2 + Vector3(- groundSize , 0,0),
			pos2 + Vector3(-width       , 0,0),
			colGround, colGround, colGround, colGround)
		addQuad(
			pos1 + Vector3( -width * 0.8, -depth,0),
			pos1 + Vector3( -width      , 0,0),
			pos2 + Vector3( -width      , 0,0),
			pos2 + Vector3( -width * 0.8, -depth,0),
			colTrail, colGround, colGround, colTrail)
		addQuad(
			pos1 + Vector3( width * 0.8, -depth,0),
			pos1 + Vector3(-width * 0.8, -depth,0),
			pos2 + Vector3(-width * 0.8, -depth,0),
			pos2 + Vector3( width * 0.8, -depth,0),
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
	end()
