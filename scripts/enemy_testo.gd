extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var beam = get_node("Beam")
	beam.rotation = (beam.global_position - get_viewport().get_mouse_position()).angle()
	for enemy in get_node("spawner").spawned:
		if (beam.in_zone(enemy.global_position)):
			enemy.apply_force((enemy.global_position-beam.global_position)*7.5)
			enemy.apply_torque(PI*enemy.mass*1000)
		#else:
		#	enemy.rotation = 0
	pass
