extends KinematicBody2D
enum MODE {search, chase}
enum MOVE_MODE {x,y}
enum DIRECTION {up, down, left, right}
var explosion = load("res://effects/simple-explosion/simple-explosion.tscn")
var vel = Vector2()
export var speed = 300
export var timeout = 10
var target_mode = MOVE_MODE.x
var mode = MODE.search

var UP = Vector2(0,-speed)
var DOWN = Vector2(0,speed)
var LEFT = Vector2(-speed,0)
var RIGHT = Vector2(speed, 0)
var current_direction = DIRECTION.left
var rotUp = 0
var rotDown = 180
var rotLeft = 270
var rotRight = 90
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var target = NodePath()
# Called when the node enters the scene tree for the first time.
func _ready():
	if rand_range(0, 1) < 0.5:
		target_mode = MOVE_MODE.x
	else:
		target_mode = MOVE_MODE.y
	$Timer.start(timeout)
	vel = Vector2(0, -speed).rotated(rotation)
	

func _physics_process(delta):
	print(target)
	match mode:
		MODE.chase:
			_chase()
		MODE.search:
			_search()
	vel = move_and_slide(vel)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
func _chase():
	
	match target_mode:
		MOVE_MODE.x:
			_chase_x()
		MOVE_MODE.y:
			_chase_y()

func _chase_x():
	if (position.x < target.position.x):
		if current_direction == DIRECTION.left:
			target_mode = MOVE_MODE.y
		else:
			vel = RIGHT
			rotation_degrees = rotRight
			current_direction = DIRECTION.right
	elif target.position.x < position.x:
		if current_direction == DIRECTION.right:
			target_mode = MOVE_MODE.y
		else:
			vel = LEFT
			rotation_degrees = rotLeft
			current_direction = DIRECTION.left
func _chase_y():
	if (position.y < target.position.y):
		if current_direction == DIRECTION.up:
			target_mode = MOVE_MODE.x
		else:
			vel = DOWN
			rotation_degrees = rotDown
			current_direction = DIRECTION.down
	elif target.position.y < position.y:
		if current_direction == DIRECTION.down:
			target_mode = MOVE_MODE.x
		else:
			vel = UP
			rotation_degrees = rotUp
			current_direction = DIRECTION.up

func _search():
	print("SEARCHING")
	var bodies = $TargetArea.get_overlapping_bodies()
	for body in bodies:
		if body.has_method("is_player"):
			target = body
			body
			mode = MODE.chase

func _explode():
	var boom = explosion.instance()
	get_parent().add_child(boom)
	boom.global_position = global_position
	queue_free()

func _on_Area2D_body_entered(body):
	_explode()


func _on_Timer_timeout():
	_explode()
