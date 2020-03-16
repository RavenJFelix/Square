extends KinematicBody2D

const GRAV = 20
export var JUMP_POWER = 500
export var speed = 500
export var max_jumps = 2
var motion = Vector2(0, 0)
var UP = Vector2(0,-1)
var consecutive_jumps = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass

func set_speed(new_speed):
	speed = new_speed

func get_speed():
	return speed

#Checks for certain input events and executes code accordingly
func check_and_exec():
	# Jumping Mechanics
	if Input.is_action_just_pressed("ui_up") and is_jumpable():
		motion.y = -JUMP_POWER
		consecutive_jumps += 1
	
	# Lateral Motion
	if Input.is_action_pressed("ui_left"):
		motion.x = -speed
	elif Input.is_action_pressed("ui_right"):
		motion.x = speed
	else:
		motion.x = 0

func is_jumpable():
	if consecutive_jumps <= max_jumps:
		return true
	else:
		return false

func reset_jumps(jumpnum = 0):
	consecutive_jumps = jumpnum

func process_state():
	if is_on_floor():
		reset_jumps()

func ambient_physical():
	#Gravity Processing
	motion.y += GRAV
func _physics_process(delta):
	#print(consecutive_jumps)
	check_and_exec()
	process_state()
	motion = move_and_slide(motion, UP)

