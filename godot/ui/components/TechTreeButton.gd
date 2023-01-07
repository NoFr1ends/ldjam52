tool
extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var techtree_id = "" setget set_id, get_id
export var myTexture : Texture setget set_texture, get_texture
export var regularTheme : Theme
export var unlockedTheme : Theme

export var id = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	set_id(id)
	connect("pressed", self, "_pressed")

func set_id(value):
	id = value
	_refresh()
func get_id():
	return id
func set_texture(value):
	$Icon.texture = value
func get_texture():
	return $Icon.texture
func _refresh():
	if !is_inside_tree():
		return
	var techtree = get_node("%TechTree")
	if techtree != null:
		$Label.text = techtree.get_entry_name_short(id)
		var is_unlocked = techtree.is_entry_unlocked(id)
		if is_unlocked:
			theme = unlockedTheme
			disabled = true
		else:
			theme = regularTheme
			var can_unlock = techtree.can_unlock_entry(id)
			disabled = !can_unlock
		var cost = techtree.get_entry_cost(id)
		if cost > 0 && !is_unlocked:
			$Cost.visible = true
			$Cost.text = String(cost) + "$"
		else:
			$Cost.visible = false
	else:
		$Label.text = "NOT_FOUND"
		
func _pressed():
	if !is_inside_tree():
		return
	var techtree = get_node("%TechTree")
	techtree.unlock_entry(id)
	_refresh()
	var allButtons = []
	_findByClass(get_tree().root.get_child(0), allButtons)
	for button in allButtons:
		button._refresh()
	
func _findByClass(node: Node, result : Array) -> void:
	if node.get_script() == self.get_script():
		result.push_back(node)
	for child in node.get_children():
		_findByClass(child, result)

