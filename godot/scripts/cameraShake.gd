extends Camera


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var startingPos
var startingRotation
var continuous = true

export (float) var elapsed = 0.0
export (float) var ampFactorDrive := 0.1
export (float) var ampFactorShake := 1.0
export (float) var countdown := 0.0
export (float) var single_hit_countdown := .3


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("/root/Main/Player").connect("explosion", self, "single_shake")
	startingPos = translation
	startingRotation = global_rotation


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	elapsed += delta
	if continuous:
		translation = startingPos + Vector3(sin(elapsed*100) * 2 * ampFactorDrive, cos(elapsed*80+1) *1.5* ampFactorDrive, sin(elapsed*90+2)*1.8* ampFactorDrive)
	if countdown > 0:
		translation = startingPos + Vector3(sin(elapsed*100) * 2 * ampFactorShake, cos(elapsed*80+1) *1.5* ampFactorShake, sin(elapsed*90+2)*1.8* ampFactorShake)
		countdown -= delta


func single_shake():
	countdown = single_hit_countdown
	
