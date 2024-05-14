class_name HealthEffect

extends CombatEffect

const effect_id = effect_type.HEALTH

# this effect needs to be expanded with DOT and so on
# maybe this should be inside BaseEntity after all
func apply(entity : BaseEntity):
	entity.stats.current_health = min(entity.stats.current_health - effect_power, entity.stats.max_health)
	applied_on = entity
	if effect_power > 0:
		takes_damage()
	else:
		takes_heal()

#damage function
func takes_damage():
	if applied_on.healthbar.value <= 0:
		pass

#heal function
func takes_heal():
	pass
