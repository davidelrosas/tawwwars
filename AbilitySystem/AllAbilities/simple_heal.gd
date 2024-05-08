extends Node2D

@export var max_targets : int
@export var effects_list : Array[CombatEffect]
var target

func cast(target_data : Target, caster : BaseEntity):
	target = target_data.find_lowest_health()
	if target != null:
		target.effect(effects_list)
		print("heals")
		print(target)
	else:
		print("no target in sight")
