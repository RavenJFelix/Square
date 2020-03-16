extends Polygon2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_StaticBody2D_body_entered(body):
	if body.has_method("mode_climb"):
		body.mode_climb()

func _on_StaticBody2D_body_exited(body):
	if body.has_method("mode_normal"):
		body.mode_normal()
