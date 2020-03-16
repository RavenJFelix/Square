extends Polygon2D

export var damage = 10



func _on_StaticBody2D2_body_entered(body):
	if body.has_method("damage"):
		body.damage(damage)
