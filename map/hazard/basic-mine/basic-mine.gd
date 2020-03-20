extends Polygon2D
var explosion = load("res://effects/simple-explosion/simple-explosion.tscn")

func _on_StaticBody2D_body_entered(body):
	if body.has_method("is_player"):
		var boom = explosion.instance()
		boom.global_position = global_position
		get_node("/root").call_deferred("add_child", boom)

		queue_free()
