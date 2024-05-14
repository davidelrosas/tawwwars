class_name TauntEffect

extends CombatEffect

const effect_id = effect_type.TAUNT

@export var duration : float
var backup

#this effect needs an entire revamp
#this is literally exactly the same as slow so it can probably go in combat effect and then other special
#effects just do apply different, for example health effect
func apply(entity : BaseEntity):
	applied_on = entity
	if duration as bool:
		set_timer(duration)
	modify_stats()
	activate_effect()

func end_effect():
	applied_on.target_data.current_targets = backup
	applied_on.active_effects[effect_id].erase(self)
	# and set var dont_change_target to FALSE again
	#work on hierarchy later
	super.end_effect()

func modify_stats():
	#obviously this has to change depending on the mob movement and so on
	backup = applied_on.target_data.current_targets
	applied_on.target_data.flush_current_targets()
	applied_on.target_data.current_targets.append(casted_from)
	#set a var in Target later called dont_change_target to TRUE
