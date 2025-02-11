class_name HomingMovement

extends MovementEngine

var position_prev_frame : Vector2

#probably also connect to abilities, impact detection!

func _physics_process(delta):
	if not target:
		# how do we get this direction
		direction  = (ability.position - position_prev_frame).normalized()
		ability.global_position += direction * speed * delta
	else:
		position_prev_frame = ability.position
		ability.look_at(target.global_position)
		ability.position = ability.position.move_toward(target.global_position, speed*delta)
	

