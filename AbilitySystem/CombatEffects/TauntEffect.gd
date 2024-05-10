class_name TauntEffect

extends CombatEffect

const effect_id = effect_type.TAUNT

@export var duration : float
var backup

func apply(entity : BaseEntity):
	applied_on = entity
	#how is the hierarchy here
	backup = entity.target_data.current
	entity.target_data.current = casted_from
	effect_is_active = true
	
	set_timer(duration)
	
	entity.active_effects.append(self)
	entity.add_child(self)

func _on_timer_timeout():
	applied_on.target_data.current = backup
	end_effect()
