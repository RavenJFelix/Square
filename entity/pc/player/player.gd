extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const GRAV = 20
const JUMP_POWER = 500
const SPEED = 500
var motion = Vector2(0, 0)
var UP = Vector2(0,-1)
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass

func checkAndExec():
	if Input.is_action_pressed("ui_up") and is_on_floor():
		motion.y = -JUMP_POWER
	if Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
	elif Input.is_action_pressed("ui_right"):
		motion.x = SPEED
	else:
		motion.x = 0
	motion.y += GRAV
	motion = move_and_slide(motion, UP)

func _physics_process(delta):
	checkAndExec()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
