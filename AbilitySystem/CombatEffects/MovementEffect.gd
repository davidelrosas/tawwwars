class_name MovementEffect

extends CombatEffect

const effect_id = effect_type.MOVEMENT
const subsequent_reduction_factor = 0.3

@export var duration : float
@export var modifier : modifier_type

#this effect should only be applicable to mobs right?
#if duration is 0 then make it infinite
func apply(entity : BaseEntity):
	applied_on = entity
	if duration as bool:
		set_timer(duration)
	activate_effect()
	modify_stats()
	print(applied_on.active_effects)

func end_effect():
	applied_on.active_effects[effect_id].erase(self)
	modify_stats()
	super.end_effect()

func modify_stats():
	applied_on.stats.apply_modifier(effect_id, subsequent_reduction_factor)
