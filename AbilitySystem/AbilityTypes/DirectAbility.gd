class_name DircetAbility

extends Ability


func cast(target : Target, caster):
	if target.current != null:
		target.effect(effects_list)
	else:
		target.current = target.find_closest(caster)
		if target.current != null:
			pass
	match cast_position_id:
		cast_position.ONTARGET:
			pass

func ontraget():
	pass
