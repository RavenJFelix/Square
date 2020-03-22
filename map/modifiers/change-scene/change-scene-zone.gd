extends Polygon2D

export var scene = ""
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var color_change_rate = 0.001
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	color.h += 0.001

func _on_ChangeScene_body_entered(body):
	get_tree().change_scene(scene)
