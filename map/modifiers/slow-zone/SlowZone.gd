extends Area2D
export var slowdown_ratio = 0.5
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#STORE THE ORIGINAL MULTS IN EACH SLOWABLE ENTITY SO WHEN THEY EXIT NO SHIT HAPPENS
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SlowZone_body_entered(body):
	if body.has_method("set_speed_mult"):
		body.set_speed_mult(slowdown_ratio)


func _on_SlowZone_body_exited(body):
	if body.has_method("set_speed_mult"):
		body.set_speed_mult(1.0)
