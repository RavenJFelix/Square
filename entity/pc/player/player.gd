extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const GRAV = 20
const JUMP_POWER = 500
const SPEED = 500
export var max_jumps = 2
var motion = Vector2(0, 0)
var UP = Vector2(0,-1)
var consecutive_jumps = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass

func check_and_exec():
	if Input.is_action_just_pressed("ui_up") and is_jumpable():
		motion.y = -JUMP_POWER
		consecutive_jumps += 1
	if Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
	elif Input.is_action_pressed("ui_right"):
		motion.x = SPEED
	else:
		motion.x = 0
	motion.y += GRAV
	motion = move_and_slide(motion, UP)

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

func _physics_process(delta):
	#print(consecutive_jumps)
	check_and_exec()
	process_state()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
