tool
extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var speed_mult  = 1.0
var money_mult  = 1.0
var coal_mult   = 1.0

var data = {
	"wheels_lvl1" : {
		"name"        : "Wheels Level 1",
		"name_short"  : "LVL 1",
		"description" : "Bagger goes faster",
		"depends_on"  : [],
		"cost"        : 0,
		"speed_mult"  : 1.0,
		"unlocked"    : true,
	},
	"wheels_lvl2" : {
		"name"        : "Wheels Level 2",
		"name_short"  : "LVL 2",
		"description" : "Bagger goes faster",
		"depends_on"  : ["wheels_lvl1"],
		"cost"        : 100,
		"speed_mult"  : 1.5,
		"unlocked"    : false,
	},
	"wheels_lvl3" : {
		"name"        : "Wheels Level 3",
		"name_short"  : "LVL 3",
		"description" : "Allows you to mount a bigger bagger body",
		"depends_on"  : ["wheels_lvl2"],
		"cost"        : 500,
		"speed_mult"  : 2.0,
		"unlocked"    : false,
	},
	"body_lvl1" : {
		"name"        : "Body Level 1",
		"name_short"  : "LVL 1",
		"description" : "",
		"depends_on"  : [],
		"cost"        : 0,
		"money_mult"  : 1.0,
		"unlocked"    : true,
	},
	"body_lvl2" : {
		"name"        : "Body Level 2",
		"name_short"  : "LVL 2",
		"description" : "Shiny paintjob! 150% revenue",
		"depends_on"  : ["body_lvl1"],
		"cost"        : 300,
		"money_mult"  : 1.5,
		"unlocked"    : false,
	},
	"body_lvl3" : {
		"name"        : "Body Level 3",
		"name_short"  : "LVL 3",
		"description" : "Intimidating Design 200% revenue.\nAllows you to mount a bigger shovel!",
		"depends_on"  : ["body_lvl2", "wheels_lvl3"],
		"cost"        : 800,
		"money_mult"  : 2.0,
		"unlocked"    : false,
	},
	"shovel_lvl1" : {
		"name"        : "Shovel Level 1",
		"name_short"  : "LVL 1",
		"description" : "",
		"depends_on"  : [],
		"cost"        : 0,
		"coal_mult"   : 1.0,
		"unlocked"    : true,
	},
	"shovel_lvl2" : {
		"name"        : "Shovel Level 2",
		"name_short"  : "LVL 2",
		"description" : "Coal mining efficiency: 120%",
		"depends_on"  : ["shovel_lvl1"],
		"cost"        : 100,
		"coal_mult"   : 1.2,
		"unlocked"    : false,
	},
	"shovel_lvl3" : {
		"name"        : "Shovel Level 3",
		"name_short"  : "LVL 3",
		"description" : "Coal mining efficiency: 150%",
		"depends_on"  : ["shovel_lvl2"],
		"cost"        : 300,
		"coal_mult"   : 1.5,
		"unlocked"    : false,
	},
	"shovel_lvl4" : {
		"name"        : "Shovel Level 4",
		"name_short"  : "LVL 4",
		"description" : "Coal mining efficiency: 300%",
		"depends_on"  : ["shovel_lvl3", "body_lvl3"],
		"cost"        : 600,
		"coal_mult"   : 3.0,
		"unlocked"    : false,
	},
	"shovel_lvl5" : {
		"name"        : "Shovel Level 5",
		"name_short"  : "LVL 5",
		"description" : "Coal mining efficiency: 400%",
		"depends_on"  : ["shovel_lvl4"],
		"cost"        : 1000,
		"coal_mult"   : 4.0,
		"unlocked"    : false,
	},
	"shovel_lvl6" : {
		"name"        : "Shovel Level 6",
		"name_short"  : "LVL 6",
		"description" : "Coal mining efficiency: 500%",
		"depends_on"  : ["shovel_lvl5"],
		"cost"        : 1500,
		"coal_mult"   : 5.0,
		"unlocked"    : false,
	},
}

func get_entry_name(id : String) -> String :
	if !data.has(id):
		return "NOT_FOUND"
	return data.get(id).get("name")

func get_entry_name_short(id : String) -> String :
	if !data.has(id):
		return "NOT_FOUND"
	return data.get(id).get("name_short")

func get_entry_description(id : String) -> String :
	if !data.has(id) || !data[id].has("description"):
		return ""
	return data.get(id).get("description")

func get_entry_cost(id : String) -> int :
	if !data.has(id) || !data[id].has("cost"):
		return 0
	return data.get(id).get("cost")

func is_entry_unlocked(id : String) -> bool :
	if !data.has(id):
		return false
	if !data.get(id).has("unlocked"):
		return true
	return data.get(id).get("unlocked")

func can_unlock_entry(id : String) -> bool :
	if !data.has(id):
		return false
	# ACHTUNG: falls er hier einen Fehler meldet, habe ich den Verdacht, dass das ein Editor-Bug sein könnte, weil er das nicht immer tut bei mir
	if data.get(id).has("cost") and Bookkeeping.has_method("can_afford") and !Bookkeeping.can_afford(data[id]["cost"]):
		print_debug("can't afford %s" % id)
		print_debug("have: %s, costs: %s" % [Bookkeeping.current_coins, data[id]["cost"]])
		return false
	if !data.get(id).has("depends_on"):
		return true
	var depends_on = data[id]["depends_on"]
	for dependency in depends_on:
		if !is_entry_unlocked(dependency):
			return false
	return true

func unlock_entry(id : String) -> bool :
	if !data.has(id):
		return false
	if !can_unlock_entry(id):
		return false
	var entry = data.get(id)
	entry["unlocked"] = true
	if data[id].has("cost"):
		Bookkeeping.add_coins(-data[id]["cost"])
	speed_mult = entry.get("speed_mult", speed_mult)
	money_mult = entry.get("money_mult", money_mult)
	coal_mult  = entry.get("coal_mult",   coal_mult)
	return true

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


func refresh_unlockables():
	$Panel/Body_Lvl1.refresh_all()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	refresh_unlockables()
