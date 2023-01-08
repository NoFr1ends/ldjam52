extends Spatial

enum {
	coal,
	coin
}

export (PackedScene) var coinScene
export (PackedScene) var coalScene
export (float)  var duration = .7

onready var moveTween = $UiMoveToCountersTween
onready var camera = get_node("/root/Main/Player/Camera")

onready var coalLabel = get_node("/root/Main/Coal")
onready var moneyLabel = get_node("/root/Main/Money")

onready var coin_sound = get_node("/root/Main/CoinSound")

onready var sound_on_off_button = get_node("/root/Main/SoundOnOffButton")

var rng = RandomNumberGenerator.new()

var sceneMap = {}
var destPosMap = {}



# Called when the node enters the scene tree for the first time.
func _ready():
	print_debug("magenta thing pos in viewport : %s" % camera.unproject_position(get_node("../MeshInstance").global_translation))
	destPosMap[coal] = Vector3(-26,16.5,0)  # camera.to_local(camera.project_position(coalLabel.rect_position, 0))
	destPosMap[coin] = Vector3(26,16.5,0) # camera.to_local(camera.project_position(moneyLabel.rect_position, 0))
	sceneMap[coal] = coalScene
	sceneMap[coin] = coinScene
	rng.randomize()



func get_random_offset_vector(scale : float = 1.0):
	return Vector3(rng.randf_range(-scale,scale), rng.randf_range(-scale,scale), rng.randf_range(-scale,scale))


func instantiate(startPos : Vector3, reward, value : int = 0):
	var newElm = sceneMap[reward].instance()
	if reward == coin: 
		newElm.value = value
	add_child(newElm)
	newElm.global_translation = startPos
	var destPos = camera.project_position(coalLabel.rect_position, 5) if reward == coal else camera.project_position(moneyLabel.rect_position, 5)
	#var myTween = Tween.new()
	#newElm.add_child(myTween)
	
	moveTween.interpolate_property(newElm, "translation", newElm.translation + get_random_offset_vector(1), destPosMap[reward]  + get_random_offset_vector(1), duration, Tween.TRANS_QUART, Tween.EASE_IN)
	moveTween.start()
	#myTween.connect("tween_completed", self, "_on_UiMoveToCountersTween_tween_completed")


func _on_UiMoveToCountersTween_tween_completed(object, key):
	if "Coin" in object.name:
		if sound_on_off_button.pressed:
			if !coin_sound.playing:
				coin_sound.play()
		Bookkeeping.add_coins(object.value)
	object.queue_free()
