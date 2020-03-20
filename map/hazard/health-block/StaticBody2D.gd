extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var damaged = {}
var still = Vector2(0, 0)
# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.

func _physics_process(delta):
	var bodies = {}
	move_and_slide(still)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var collider = collision.collider
		#print("Collided with: ", collision.collider.name)
		if collider.has_method("heal") and (not damaged.has(collider)):
			get_parent().set_color_damaged()
			collider.heal(get_parent().damage)
			damaged[collider] = get_parent().damage_time
	for damaged_body in damaged:
		#print(damaged)
		damaged[damaged_body] -= delta
		if damaged[damaged_body] < 0:
			damaged.erase(damaged_body)
