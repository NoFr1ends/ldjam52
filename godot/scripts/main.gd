extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal restart
var time = 0.2


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("restart", Bookkeeping, "restart")
	Bookkeeping.restart()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta * 0.007
	#thanksoburti
	if time > 1:
		time -= 1


func win():
	$WinningOverlay.visible = true
	$Player.set_process(false)
	


func _on_RestartGameButton_pressed():
	
	get_tree().reload_current_scene()
	emit_signal("restart")


func _on_CloseHelpButton_pressed():
	$HelpPanel.visible = false


func _on_ShowHelpButton_pressed():
	$HelpPanel.visible = true
	
