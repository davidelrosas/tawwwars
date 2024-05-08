extends Node2D

@export var max_targets : int
@export var effects_list : Array[CombatEffect]

func cast(target_data : Target, caster : BaseEntity):
	initialize_combat_effects(effects_list, caster)
	var targets = target_data.in_range
	var counter = max_targets
	for i in targets:
		i.effect(effects_list)
		counter -= 1
		if counter == 0:
			return

func initialize_combat_effects(effects : Array[CombatEffect], entity):
	for i in effects:
		i.casted_from = entity
