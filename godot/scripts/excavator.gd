extends Spatial

export(float) var speed = 2.0
export(float) var rot_speed = 5.0

export(float) var angle_range_ctrl = 15 * PI / 180.0
export(float) var angle_range_steer = 10 * PI / 180.0

onready var base_excavator = $bagger/ctrl_base/ctrl_rotate


func _ready():
	pass # Replace with function body.


func _process(delta):
	translate(Vector3.FORWARD * delta* speed)
	

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		base_excavator.rotation.y -= delta * rot_speed
	if Input.is_action_pressed("ui_left"):
		base_excavator.rotation.y += delta * rot_speed
	base_excavator.rotation.y = clamp(base_excavator.rotation.y, -angle_range_ctrl, angle_range_ctrl)


	if Input.is_action_pressed("turn_right"):
		rotation.y -= delta * rot_speed
	if Input.is_action_pressed("turn_left"):
		rotation.y += delta * rot_speed
	rotation.y = clamp(rotation.y, -angle_range_steer, angle_range_steer)
