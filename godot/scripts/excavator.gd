extends Spatial

signal explosion

export(float) var speed = 2.0
export(float) var rot_speed = 5.0

export(float) var angle_range_ctrl = 15 * PI / 180.0
export(float) var angle_range_steer = 10 * PI / 180.0

export(float) var radius_wheel = 4.5
export(float) var radius_bagger = 6.8
export(float) var coal_consumption  = 10

export (int) var coal_start_stock = 1000

onready var base_excavator = $bagger/ctrl_base/ctrl_rotate
onready var obstacle_containter = get_node("/root/Main/RunnerLogic/ObstacleContainer")
onready var camera = $Camera
onready var ctrl_shovel = $bagger/ctrl_base/ctrl_rotate/ctrl_height/ctrl_shovel

onready var coal_counter = get_node("/root/Main/Coal")
onready var money_counter = get_node("/root/Main/Money")
onready var ui_collectables = get_node("/root/Main/Player/Camera/UICollectables")

onready var coal_sound = get_node("/root/Main/CoalSound")

onready var sound_on_off_button = get_node("/root/Main/SoundOnOffButton")


onready var techTree = get_node("/root/Main/Control/TechTree")

var rng = RandomNumberGenerator.new()

var sound_timeout_ct = 0
var elapsed := .0

var super_speed = false

func _process(delta):
	var money_mult = techTree.money_mult * (2 if super_speed else 1)
	var coal_mult = techTree.coal_mult * (2 if super_speed else 1)
	
	translate(Vector3.FORWARD * delta* speed * techTree.speed_mult * (2 if super_speed else 1))
	var shovelPos = ctrl_shovel.global_translation
	var baggerPos = base_excavator.global_translation
	for container in obstacle_containter.get_children():
		for obj in container.get_children():
			var obstPos = obj.global_translation
			if obstPos.z > camera.global_translation.z:
				obj.queue_free()
				continue
			if (obstPos - shovelPos).length() < (obj.radius + radius_wheel):
				obj.explode(true)
				emit_signal("explosion")
				if obj.value > 0: 
					ui_collectables.instantiate(obj.global_translation, ui_collectables.coin, obj.value)
				else:
					Bookkeeping.add_coins(obj.value)
				if obj.coal_value > 0:
					Bookkeeping.add_coal(obj.coal_value)
					ui_collectables.instantiate(shovelPos, ui_collectables.coal)
					if sound_on_off_button.pressed: 
						if !coal_sound.playing:
							coal_sound.pitch_scale = rng.randf_range(.8,1.2)
							coal_sound.play()
					
			if (obstPos - base_excavator.global_translation).length() < radius_bagger + obj.radius:
				obj.explode(false)
		
	elapsed += delta
	Bookkeeping.add_coal(-coal_consumption * (3 if super_speed else 1))
	
	if Bookkeeping.current_coal <= 0:
		# lost
		set_process(false)
		$"../LostOverlay".visible = true
#	if elapsed > .2 - log(coal_mult)*.1:
#		Bookkeeping.add_coal(coal_income)
#		ui_collectables.instantiate(shovelPos, ui_collectables.coal)
#		sound_timeout_ct += 1
#		if sound_timeout_ct % 2 == 0:
#			if sound_on_off_button.pressed: 
#				if !coal_sound.playing:
#					coal_sound.pitch_scale = rng.randf_range(.8,1.2)
#					coal_sound.play()
#
#		elapsed = 0


func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		base_excavator.rotation.y -= delta * rot_speed
	if Input.is_action_pressed("ui_left"):
		base_excavator.rotation.y += delta * rot_speed
	base_excavator.rotation.y = clamp(base_excavator.rotation.y, -angle_range_ctrl, angle_range_ctrl)

	if Input.is_action_just_pressed("speed"):
		super_speed = true
	elif Input.is_action_just_released("speed"):
		super_speed = false

	#if Input.is_action_pressed("turn_right"):
	#	rotation.y -= delta * rot_speed
	#if Input.is_action_pressed("turn_left"):
	#	rotation.y += delta * rot_speed
	#rotation.y = clamp(rotation.y, -angle_range_steer, angle_range_steer)



	

func _get_chidren_with_prefix(prefix : String, node : Node, array : Array):
	if node.name.begins_with(prefix):
		array.push_back(node)
	for child in node.get_children():
		_get_chidren_with_prefix(prefix, child, array)

func update_body():
	var mesh_parts = techTree.mesh_parts
	var keys = mesh_parts.keys()
	for key in keys:
		var parts = []
		_get_chidren_with_prefix(key, self, parts)
		var partname = key + mesh_parts[key]
		for part in parts:
			if part.name == partname:
				part.show()
			else:
				part.hide()


func _ready():
	rng.randomize()
	Bookkeeping.current_coal = coal_start_stock
