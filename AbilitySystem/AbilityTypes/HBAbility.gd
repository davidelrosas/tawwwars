class_name HBAbility

extends Ability

@export var cast_position_id : cast_position
@export var hitbox : HitBox


enum cast_position {ONTARGET, ONSELF}

func cast(target : Target, caster):
	hitbox.effects_list = self.effects_list
	hitbox.set_layer(caster.team_id)
	#you are right all of this should be done by the target class
	if target.current != null:
		shoot(target, caster)
	else:
		target.current = target.find_closest(caster)
		if target.current != null:
			shoot(target, caster)

func shoot(target, caster):
	look_at(global_position + target.current.global_position)
	if cast_position_id == cast_position.ONTARGET:
		global_position = target.current.global_position
	else:
		global_position = caster.global_position
		
	set_as_top_level(true)
	caster.get_parent().add_child(self)
