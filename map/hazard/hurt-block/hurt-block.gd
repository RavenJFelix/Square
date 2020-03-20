extends Polygon2D

export var damage = 10
export var damage_time = 0.75
export var damage_color = Color(0.0, 0.0, 0.0)
export var regular_color = Color(0.0, 0.0, 0.0)
export var color_restore_speed = 0.05

func set_color_damaged():
	color = damage_color

func set_color_regular():
	color = regular_color

func restore_color_regular():
	color =lerp(color, regular_color, color_restore_speed)

func _physics_process(delta):
	restore_color_regular()