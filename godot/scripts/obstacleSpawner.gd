extends Spatial


var rng = RandomNumberGenerator.new()

export (float) var spawn_rate_min = .1
export (float) var spawn_rate_max = 1.0

export (NodePath) var types
#onready var runner = get_node("/root/Main/Player/ObstacleSpawner")
onready var obstacleContainer = get_node("/root/Main/RunnerLogic/ObstacleContainer")

var count_down = 0.0
var typeList

func _ready():
	rng.randomize()
	


#func _process(delta):
#	count_down -= delta
#	if count_down < 0.0:
#		var idx = rng.randi_range(0, types.size() - 1)
#		var sceneList = types[idx].get_children()
#		var subIdx = rng.randi_range(0, sceneList.size() - 1)
#		var newElm = spawnableItems[idx].instance()
#		obstacleContainer.add_child(newElm)
#		newElm.global_translation = self.global_translation
#		newElm.global_translation += Vector3(rand_range(-10 , 10), 0, rand_range(-10 , 10))
#		count_down = rng.randf_range(spawn_rate_min, spawn_rate_max)
