extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var coal_amount = 500 
export (int) var coal_cost = 100 
export var regularTheme : Theme
export var unlockedTheme : Theme


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Bookkeeping.current_coins > coal_cost && Bookkeeping.current_coal > -coal_amount:
		disabled = false
	else:
		disabled = true


func _on_CashFromCoal_pressed():
	if Bookkeeping.current_coins > coal_cost && Bookkeeping.current_coal > -coal_amount:
		Bookkeeping.current_coal += coal_amount
		Bookkeeping.current_coins -= coal_cost
	


func _on_CashFromCoal_mouse_entered():
	var techtree = get_node("%TechTree")
	if coal_amount > 0:
		techtree.get_node("Panel/Description").text = "Buy %s coal for %s$ to refuel the machine" % [coal_amount, coal_cost]
	else:
		techtree.get_node("Panel/Description").text = "Sell %s coal for %s$ to please the stakeholders" % [-coal_amount, -coal_cost]
