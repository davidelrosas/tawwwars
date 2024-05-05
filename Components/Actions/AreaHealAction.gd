extends Action

var max_targets : int

func cast(target : Target, caster : BaseEntity):
	var heal = CombatEffect.new()
	heal.power = - caster.stats.ability_modifier
	for i in target.in_range:
		if i.has_method("effect"):
			i.effect(heal) 
