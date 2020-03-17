extends Area2D
var damage_done = false
export var damage = 10
export var extinguish_time = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start(extinguish_time)
	pass # Replace with function body.
func _physics_process(delta):
	if not damage_done:
		var bodies_in_area = get_overlapping_bodies()
		for body in bodies_in_area:
			if body.has_method("damage"):
				body.damage(damage)
				damage_done = true
	$Polygon2D.color.a = ($Timer.time_left / extinguish_time)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	queue_free()
