extends Area2D
export var slowdown_ratio = 0.5

func _ready():
	pass # Replace with function body.

func _on_SlowZone_body_entered(body):
	if body.has_method("set_speed_mult"):
		body.set_speed_mult(slowdown_ratio)
	if body.has_method("suppress_max_jumps"):
		body.suppress_max_jumps()

func _on_SlowZone_body_exited(body):
	if body.has_method("set_speed_mult"):
		body.set_speed_mult(1.0)
	if body.has_method("restore_max_jumps"):
		body.restore_max_jumps()

