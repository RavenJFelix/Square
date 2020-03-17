extends Polygon2D
var explosion = load("res://effects/explosion/explosion.tscn")

func _on_StaticBody2D_body_entered(body):
	if body.has_method("is_player"):
		var boom = explosion.instance()
		get_parent().add_child(boom)
		queue_free()
