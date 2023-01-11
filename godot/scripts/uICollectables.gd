extends Node3D

enum {
	coal,
	coin
}

@export var coinScene: PackedScene
@export var coalScene: PackedScene
@export var duration = .7

@onready var camera = get_node("/root/Main/Player/Camera3D")

@onready var coalLabel = get_node("/root/Main/Coal")
@onready var moneyLabel = get_node("/root/Main/Money")

@onready var coin_sound = get_node("/root/Main/CoinSound")

@onready var sound_on_off_button = get_node("/root/Main/SoundOnOffButton")

var rng = RandomNumberGenerator.new()

var sceneMap = {}
var destPosMap = {}



# Called when the node enters the scene tree for the first time.
func _ready():
	print_debug("magenta thing pos in viewport : %s" % camera.unproject_position(get_node("../MeshInstance3D").global_position))
	destPosMap[coal] = Vector3(-26,16.5,0)  # camera.to_local(camera.project_position(coalLabel.position, 0))
	destPosMap[coin] = Vector3(26,16.5,0) # camera.to_local(camera.project_position(moneyLabel.position, 0))
	sceneMap[coal] = coalScene
	sceneMap[coin] = coinScene
	rng.randomize()



func get_random_offset_vector(scale : float = 1.0):
	return Vector3(rng.randf_range(-scale,scale), rng.randf_range(-scale,scale), rng.randf_range(-scale,scale))


func instantiate(startPos : Vector3, reward, value : int = 0):
	var newElm = sceneMap[reward].instantiate()
	if reward == coin: 
		newElm.value = value
	add_child(newElm)
	newElm.global_position = startPos
	var destPos = camera.project_position(coalLabel.position, 5) if reward == coal else camera.project_position(moneyLabel.position, 5)

	var tween = get_tree().create_tween()
	newElm.position = newElm.position + get_random_offset_vector(1)
	tween.set_trans(Tween.TRANS_QUART)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(newElm, "position", destPosMap[reward] + get_random_offset_vector(1), duration)
	tween.tween_callback(_on_UiMoveToCountersTween_tween_completed.bind(newElm))


func _on_UiMoveToCountersTween_tween_completed(object):
	if "Coin" in object.name:
		if sound_on_off_button.pressed:
			if !coin_sound.playing:
				coin_sound.play()
		Bookkeeping.add_coins(object.value)
	object.queue_free()
