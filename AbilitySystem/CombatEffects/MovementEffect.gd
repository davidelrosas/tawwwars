class_name MovementEffect

extends CombatEffect

const effect_id = effect_type.MOVEMENT

@export var duration : float

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
	applied_on.current_speed = applied_on.stats.movement_speed
	#there has to be a more efficient way
	#or should be inside get effects
	var same_type_effects = get_effects(effect_id)
	same_type_effects.erase(self)
	if same_type_effects.size() > 0:
		for i in same_type_effects:
			i.modify_stats()
	
	super.end_effect()

func modify_stats():
	var same_type_effects = get_effects(effect_id)
	applied_on.entity.stats.fill_modifiers(same_type_effects.map(func(x):((100 + x.effect_power)/100)-1))
	applied_on.entity.stats.apply_modifier(effect_id)

