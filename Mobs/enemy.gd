class_name AI
extends RigidBody2D

@export_group("Enemy properties")
@export var target := Target.new()
@export var speed = 100
@export var acceleration = 100

func _process(delta):
	if target.current != null:
		var to_target = target.current.global_position - global_position
		to_target = to_target.normalized()
		if to_target.dot(linear_velocity) <= 0:
			to_target *= 3
		apply_central_force(to_target*acceleration)
		var curspeed = linear_velocity.length_squared()
		if curspeed > speed*speed:
			linear_velocity *= (speed / sqrt(curspeed))
	else:
		if target.in_range != []:
			target.current = target.in_range[0]
		else:
			var to_target = Vector2(0,0) - global_position
			to_target = to_target.normalized()
			if to_target.dot(linear_velocity) <= 0:
				to_target *= 3
			apply_central_force(to_target*acceleration)
			var curspeed = linear_velocity.length_squared()
			if curspeed > speed*speed:
				linear_velocity *= (speed / sqrt(curspeed))
