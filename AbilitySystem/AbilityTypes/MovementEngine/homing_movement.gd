class_name HomingMovement

extends AbilityMovement

var position_prev_frame : Vector2

#probably also connect to abilities, impact detection!

func _physics_process(delta):
	if not target:
		direction = ability.posiiton - position_prev_frame
		ability.global_position += direction * speed * delta
	else:
		ability.look_at(target.global_position)
		ability.position = ability.position.move_toward(target.global_position, speed*delta)
	position_prev_frame = ability.position

