class_name DirectAbility

extends Ability

@export var cast_on_self := false

func cast(target : Target, caster):
	if max_targets == 1:
		single_cast(target, caster)
	else:
		multi_cast(target, caster)

# 0 max_targets for unlimited targets
func multi_cast(target, caster):
	var counter = max_targets
	var targets = target.in_range
	if cast_on_self == true:
		targets.push_front(caster)
		
	for i in targets:
		i.effect(effects_list)
		counter -= 1
		if counter == 0:
			return

func single_cast(target, caster):
	if target.current != null:
		target.current.effect(effects_list)
	else:
		if cast_on_self == true:
			target.current = caster
		else:
			target.current = target.find_closest(caster)
			if target.current == null:
				return
		target.current.effect(effects_list)
