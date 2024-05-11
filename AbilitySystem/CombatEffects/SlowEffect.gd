class_name SlowEffect

extends CombatEffect

const effect_id = effect_type.MOVEMENT

@export var duration : float

#this effect should only be applicable to mobs right?
#if duration is 0 then make it infinite
func apply(entity : BaseEntity):
	applied_on = entity
	if duration as bool:
		set_timer(duration)
	modify_stats()
	activate_effect()
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
	#when applying it also recalculates all same type effects
	# How do we check instead which of the effects is stronger
	# this is gonna have to change if we want stackable movement speed
	var modified_speed = applied_on.stats.movement_speed * max((100-effect_power)/100, 0)
	if modified_speed < applied_on.current_speed:
		applied_on.current_speed = modified_speed
