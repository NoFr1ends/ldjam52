extends Node3D


var rng = RandomNumberGenerator.new()

@export var spawn_rate_min = .1
@export var spawn_rate_max = 1.0
@export var x_variation_range: float = 10
@export var z_variation_range: float = 10

@export var coal_count_down_start = 3.0


#export (NodePath) var types
#onready var runner = get_node("/root/Main/Player/ObstacleSpawner")
@onready var obstacleContainer = get_node("/root/Main/RunnerLogic/ObstacleContainer")
@onready var obstacleList = get_node("/root/Main/ObstacleList")
@onready var player = get_node("/root/Main/Player")

var count_down = 0.0
var typeList
var likelihoods = []
var coal_count_down = coal_count_down_start

func _ready():
	rng.randomize()
	var sum := 0.0
	for elm in obstacleList.get_children():
		likelihoods.append(elm.likelihood)
		sum += elm.likelihood
	for lh in likelihoods:
		lh *= 1.0/sum

func spawn_element(fixed_type = -1):
	var idx = 0
	if fixed_type == -1:
		var type = rng.randf()
		var lhSum = 0.0
		while (lhSum < type):
			lhSum += likelihoods[idx]
			idx += 1
		idx -= 1
	else:
		idx = fixed_type
	
	var typeHolder = obstacleList.get_child(idx)
	var subIdx = rng.randi_range(0, typeHolder.scenes.size() - 1)
	var spawnItem = typeHolder.scenes[subIdx]
	var newElm = spawnItem.instantiate()
	obstacleContainer.add_child(newElm)
	newElm.global_position = self.global_position
	newElm.rotation.y = rng.randf_range(-PI, PI)
	newElm.global_position += Vector3(randf_range(-x_variation_range , x_variation_range), 0, randf_range(-z_variation_range , z_variation_range))
	
	

func _process(delta):
	count_down -= delta * player.get_velocity() / player.speed
	coal_count_down -= delta
	if coal_count_down < 0.0:
		count_down += 1.7
		spawn_element(3)
		coal_count_down = coal_count_down_start
		
	if count_down < 0.0:
		spawn_element()
		
		count_down = rng.randf_range(spawn_rate_min, spawn_rate_max)
