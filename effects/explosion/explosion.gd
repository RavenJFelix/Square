extends Area2D

enum MODE {end_color, fade}
export var damage = .5
export var color_change_speed = 0.1
export var growth_rate = 3
export var start_color = Color()
export var end_color = Color()
var current_color = Color()
var target_color = Color()
export var radius = 200
var mode
# Called when the node enters the scene tree for the first time.
func _ready():
	mode = MODE.end_color
	current_color = start_color
	target_color = end_color
	update_collision_radius()

	pass # Replace with function body.

func update_collision_radius():
	get_node("CollisionShape2D").get_shape().set_radius(radius)

func general_update():
	update_collision_radius()
	update()

func _physics_process(delta):
	var bodies_in_area = get_overlapping_bodies()
	for body in bodies_in_area:
		if body.has_method("damage"):
			body.damage(damage)
	current_color = lerp(current_color, target_color, color_change_speed)
	radius += growth_rate
	update_collision_radius()
	general_update()
	if (colors_are_equal(current_color, target_color, 0.1)):
		match mode:
			MODE.end_color:
				target_color = Color(target_color.r, target_color.g, target_color.b, 0)
				mode = MODE.fade
			MODE.fade:
				if (colors_are_equal(current_color, target_color, 0.1)):
					queue_free()


func colors_are_equal(color1, color2, epsilon):
	if  ((abs(current_color.r - end_color.r) < epsilon) and
		(abs(current_color.g - end_color.g) < epsilon) and
		(abs(current_color.b - end_color.b) < epsilon) and
		(abs(current_color.h - end_color.h) < epsilon) and
		(abs(current_color.s - end_color.s) < epsilon) and
		(abs(current_color.v - end_color.v) < epsilon) and
		(abs(current_color.a - end_color.a) < epsilon)):
		return true
	else:
		return false
	
	
func _draw():
	draw_circle_arc_poly(position, radius, 0, 360, current_color)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func draw_circle_arc_poly(center, radius, angle_from, angle_to, color):
    var nb_points = 32
    var points_arc = PoolVector2Array()
    points_arc.push_back(center)
    var colors = PoolColorArray([color])

    for i in range(nb_points + 1):
        var angle_point = deg2rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
        points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
    draw_polygon(points_arc, colors)

