extends KinematicBody2D
enum MODE {chase, search}
var vel = Vector2()
var start_speed = 100
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var target
# Called when the node enters the scene tree for the first time.
func _ready():
	vel = Vector2(0, -start_speed).rotated(rotation)

func _physics_process(delta):
	vel = move_and_slide(vel)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
