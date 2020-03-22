extends Area2D
export var slowdown_ratio = 0.5

func _ready():
	pass # Replace with function body.
# Temmplate 
func _on_SlowZone_body_entered(body):
	if body.has_method("method"):
		body.method()

func _on_SlowZone_body_exited(body):
	if body.has_method("method"):
		body.method()

