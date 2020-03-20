extends KinematicBody2D

enum MODE {normal, climb}

var GRAV = 20
export var climb_lat_speed = 100
export var climb_speed = 300
export var JUMP_POWER = 600
export var speed = 500
export var max_jumps = 1
export var speed_mult = 1.0

export var health = 100

var alive = true
var UP = Vector2(0,-1)
var motion = Vector2(0, 0)
var consecutive_jumps = 0
var jump_buffer = 0
var in_air = true

var max_jump_buffered = false
var mode = MODE.normal

var gui
# Called when the node enters the scene tree for the first time.
func _ready():
	gui = get_node("PlayerGUI")
	_update_health_display(health)
	
func flip_gravity():
	UP = -UP
	GRAV = -GRAV
	JUMP_POWER = -JUMP_POWER
func die():
	if alive:
		gui.load_death_screen()
		alive = false
		

func damage(damage):
	assert(damage  > 0)
	health -=damage
	_update_health_display(health)
	if health < 0:
		die()

func heal(heal_amount):
	assert(heal_amount > 0)
	_update_health_display(health)
	health += heal_amount

func _update_health_display(health):
	gui.update_health(health)
func suppress_max_jumps():
	jump_buffer = max_jumps
	max_jumps = 0
	max_jump_buffered = true
	#print("max jumps" + String(max_jumps) + String(jump_buffer))
func restore_max_jumps():
	if max_jump_buffered:
		max_jumps = jump_buffer
		max_jump_buffered = false

func mode_normal():
	mode = MODE.normal

func mode_climb():
	mode = MODE.climb

func get_motion():
	return motion

func set_speed_mult(new_speed_mult):
	speed_mult = new_speed_mult

func get_speed_mult():
	return speed_mult
	
func is_player():
	pass
	
func is_moving_down():
	if motion.y > 0:
		return true
	else:
		return false

func set_speed(new_speed):
	speed = new_speed

func get_speed():
	return speed

func is_jumpable():
	if consecutive_jumps < max_jumps:
		#print("JUMP")
		return true
	else:
		return false

#Motion Handling
func _physics_process(delta):
	match (mode):
		MODE.normal:
			normal_mode()
		MODE.climb:
			climb_mode()
#Normal Mode 
func normal_mode():
	check_and_exec_reg()
	process_state()
	ambient_physical()
	motion = move_and_slide(motion, UP)
#Checks for certain input events and executes code accordingly
func check_and_exec_reg():
	#print(is_jumpable())
	#print(consecutive_jumps)
	# Jumping Mechanics
	if Input.is_action_just_pressed("ui_up") and is_jumpable():
		
		motion.y = -JUMP_POWER
		consecutive_jumps += 1
		set_safe_margin(0.001)
		in_air = 1
		set_safe_margin(0.01)
	# Lateral Motion
	if Input.is_action_pressed("ui_left"):
		motion.x = -speed * speed_mult
	elif Input.is_action_pressed("ui_right"):
		motion.x = speed * speed_mult
	else:
		motion.x = 0
func ambient_physical():
	#Gravity Processing
	motion.y += GRAV

func reset_jumps(jumpnum = 0):
	consecutive_jumps = jumpnum

func process_state():
	if is_on_floor() and in_air:
		reset_jumps()

#Climb Mode
func climb_mode():
	check_and_exec_climb()
	motion = move_and_slide(motion, UP)

func check_and_exec_climb():
	# Vertical Motion
	if Input.is_action_pressed("ui_up"):
		motion.y = -climb_speed
	elif Input.is_action_pressed("ui_down"):
		motion.y = climb_speed
	else:
		motion.y = 0

	# Lateral Motion
	if Input.is_action_pressed("ui_left"):
		motion.x = -climb_lat_speed
	elif Input.is_action_pressed("ui_right"):
		motion.x = climb_lat_speed
	else:
		motion.x = 0




