extends KinematicBody2D
var explosion = load("res://effects/simple-explosion/simple-explosion.tscn")
var vel = Vector2()
var start_speed = 100
var timeout = 10
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

func _explode():
	var boom = explosion.instance()
	get_parent().add_child(boom)
	boom.global_position = global_position
	queue_free()

func _on_Area2D_body_entered(body):
	_explode()
