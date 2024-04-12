extends RigidBody2D

@export_group("Enemy properties")
@export var target : Vector2 = Vector2(0,0)
@export var speed = 1000
@export var acceleration = 100

func _ready():
	pass

func _process(delta):
	var to_target = target - global_position
	to_target = to_target.normalized()
	if to_target.dot(linear_velocity) <= 0:
		to_target *= 3
	apply_central_force(to_target*acceleration)
	var curspeed = linear_velocity.length_squared()
	if curspeed > speed*speed:
		linear_velocity *= (speed / sqrt(curspeed))
