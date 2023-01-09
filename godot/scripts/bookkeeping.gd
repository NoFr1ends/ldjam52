tool
extends Node

onready var techTree = get_node("/root/Main/Control/TechTree")

onready var coal_counter = get_node("/root/Main/Coal")
onready var money_counter = get_node("/root/Main/Money")

var current_coins = 0
var current_coal = 0.0


func _process(delta):
	#text = String(techtree.speed_mult)
	#text = String(techtree.money_mult)
	#text = String(techtree.coal_mult)
	pass


func _ready():
	pass
	#print_debug(techTree.get_entry_name("test"))



func add_coins(sum : int):
	current_coins += int(sum * (techTree.money_mult if sum > 0 else 1.0))
	money_counter.text = str(current_coins) + " $"


func add_coal(amount : float):
	current_coal += float(amount * (techTree.coal_mult if amount > 0 else 1.0))
	coal_counter.text = "coal supply: %s" % int(current_coal)
	if current_coal < 100:
		coal_counter.set("custom_colors/font_color", Color(1,0,0))
	else:
		coal_counter.set("custom_colors/font_color", Color(0,0,0))



func can_afford(coin_cost : int) -> bool:
	return current_coins >= coin_cost 
