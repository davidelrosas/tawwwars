class_name DirectAbility

extends Ability

@export var text : String

func cast(target_data = owner_entity.target_data, caster = owner_entity):
	super.cast(target_data, caster)

func execute(target_data, caster):
	super.execute(target_data, caster)
	for i in target_data.current_targets:
		i.effect(effects_list)
	print(text)


#make a timed multicast option
