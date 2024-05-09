class_name HealthEffect

extends CombatEffect

const effect_id = effect_type.HEALTH

func apply(entity : BaseEntity):
	entity.healthbar.value = min(entity.healthbar.value - effect_power, entity.healthbar.max_value)
	casted_on = entity
	if effect_power > 0:
		takes_damage()
	else:
		takes_heal()

#damage function
func takes_damage():
	if casted_on.healthbar.value <= 0:
		pass

#heal function
func takes_heal():
	pass
