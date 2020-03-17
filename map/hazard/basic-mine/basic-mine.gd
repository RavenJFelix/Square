extends Polygon2D
var explosion = load("res://effects/simple-explosion/simple-explosion.tscn")

func _on_StaticBody2D_body_entered(body):
	if body.has_method("is_player"):
		var boom = explosion.instance()
		get_parent().call_deferred("add_child", boom)
		boom.global_position = $Position2D.global_position
		queue_free()
