extends KinematicBody2D

var moving_right = false
var motion = Vector2()
var gravity = 20
export var speed = 500
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var manager
# Called when the node enters the scene tree for the first time.
func _ready():
	manager = get_parent()

func handle_state():
	print(get_position().x)
	print(manager.get_left_bound())
	if get_position().x < manager.get_left_bound():
		moving_right = true
	elif get_position().x > manager.get_right_bound():
		moving_right = false

func logical_motion():
	if moving_right:
		motion.x = speed
	elif not moving_right:
		motion.x = -speed

func ambient_physics():
	motion.y += gravity

func _physics_process(delta):
	handle_state()
	logical_motion()
	ambient_physics()
	motion = move_and_slide(motion)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
