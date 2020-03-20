extends CanvasLayer
export var death_screen_path = "res://gui/player/game-over/Game-Over.tscn"
var death_screen = load(death_screen_path)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_health(new_health):
	$Health.set_text("Health: " + String(new_health))

func reload_level():
	get_tree().reload_current_scene()
	get_tree().set_pause(false)
	
func load_death_screen():
	get_tree().set_pause(true)
	var oof = death_screen.instance()
	add_child(oof)