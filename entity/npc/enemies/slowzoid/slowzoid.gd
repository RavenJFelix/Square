extends KinematicBody2D

var moving_right = false
var motion = Vector2()
var gravity = 20
export var speed = 200

var manager
# Called when the node enters the scene tree for the first time.
func _ready():
	manager = get_parent()

func handle_state():
	#print(get_position().x)
	#print(manager.get_left_bound())
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
	#motion.y += gravity
	pass

func _physics_process(delta):
	handle_state()
	logical_motion()
	ambient_physics()
	motion = move_and_slide(motion)

func die():
	manager.die()

func _on_DeathBox_body_entered(body):
	if body.has_method("is_player") and body.has_method("is_moving_down"):
		if body.is_moving_down():
			die()
			body.restore_max_jumps()