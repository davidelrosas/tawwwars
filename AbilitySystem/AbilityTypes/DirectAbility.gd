class_name DirectAbility

extends Ability

@export var text : String

func cast(target_data, caster):
	super.cast(target_data, caster)

func execute(target_data, caster):
	for i in target_data.current_targets:
		i.effect(effects_list)
	print(text)
