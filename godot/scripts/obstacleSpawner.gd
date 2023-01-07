extends Spatial


var rng = RandomNumberGenerator.new()

export (Array, PackedScene) var spawnableItems
#onready var runner = get_node("/root/Main/Player/ObstacleSpawner")
onready var obstacleContainer = get_node("/root/Main/RunnerLogic/ObstacleContainer")
export var spawn_rate_min = 1.0
export var spawn_rate_max = 3.0
var count_down = 0.0

func _ready():
	rng.randomize()


func _process(delta):
	count_down -= delta
	if count_down < 0.0:
		var idx = rng.randi_range(0, spawnableItems.size()-1)
		var newElm = spawnableItems[idx].instance()
		obstacleContainer.add_child(newElm)
		newElm.global_translation = self.global_translation
		newElm.global_translation += Vector3(rand_range(-10 , 10), 0, rand_range(-10 , 10))
		count_down = rng.randf_range(spawn_rate_min, spawn_rate_max)
