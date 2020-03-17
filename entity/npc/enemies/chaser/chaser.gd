extends KinematicBody2D
enum MODE {search, chase}
enum MOVE_MODE {x,y}
var explosion = load("res://effects/simple-explosion/simple-explosion.tscn")
var vel = Vector2()
export var start_speed = 100
export var timeout = 10
var target_mode = MOVE_MODE.x
var mode = MODE.search
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var target = NodePath()
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start(timeout)
	vel = Vector2(0, -start_speed).rotated(rotation)

func _physics_process(delta):
	match mode:
		MODE.chase:
			_chase()
		MODE.search:
			_search()
	vel = move_and_slide(vel)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
func _chase():
	print("CHASING")
func _search():
	print("SEARCHING")
	var bodies = $TargetArea.get_overlapping_bodies()
	for body in bodies:
		if body.has_method("is_player"):
			target = body
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
