extends Action

var max_targets : int

func action(target : Target, caster : BaseEntity):
	var heal = HealthEffect.new()
	heal.power = - caster.stats.ability_modifier
	for i in target.in_range:
		if i.has_method("effect"):
			i.effect(heal) 
