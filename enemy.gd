extends RigidBody2D

var target = Vector2(400,400)
var speed = 1000
var acc = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var to_target = target - position
	to_target = to_target.normalized()
	if to_target.dot(linear_velocity) <= 0:
		to_target *= 3
	apply_central_force(to_target*acc)
	var curspeed = linear_velocity.length_squared()
	if curspeed > speed*speed:
		linear_velocity *= (speed / sqrt(curspeed))
	pass
