class_name TauntEffect

extends CombatEffect

const effect_id = effect_type.TAUNT

@export var duration : float
var backup

#this is literally exactly the same as slow so it can probably go in combat effect and then other special
#effects just do apply different, for example health effect
func apply(entity : BaseEntity):
	applied_on = entity
	if duration as bool:
		set_timer(duration)
	modify_stats()
	activate_effect()
	print(applied_on.active_effects)

func end_effect():
	applied_on.target_data.current = backup
	#work on hierarchy later
	super.end_effect()

func modify_stats():
	backup = applied_on.target_data.current
	applied_on.target_data.current = casted_from
