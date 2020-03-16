extends Node2D
var leftBound
var rightBound
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	leftBound = get_node("leftBound")
	rightBound = get_node("rightBound")
	assert(leftBound.get_position().x < rightBound.get_position().x)
	
func get_left_bound():
	return leftBound.get_position().x

func get_right_bound():
	return rightBound.get_position().x
