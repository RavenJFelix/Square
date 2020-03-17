extends StaticBody2D
export var missile_scene = "res://entity/npc/enemies/missile/missile.tscn"
var missile
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var shoot_interval = 0.5
export var missile_speed = 500
export var missile_timout = 10
var active = true
# Called when the node enters the scene tree for the first time.
func _ready():
	missile = load(missile_scene)
	$Timer.start(shoot_interval)
	_shoot()
	pass # Replace with function body.

func _shoot():
	var le_missile = missile.instance()
	le_missile.global_position = $MissileSpawn.global_position
	le_missile.rotation = $MissileSpawn.rotation
	le_missile.speed = missile_speed
	le_missile.timeout = missile_timout
	get_parent().call_deferred("add_child", le_missile)

	
	
	# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	_shoot()
	$Timer.start(shoot_interval)