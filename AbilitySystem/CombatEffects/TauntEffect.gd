class_name TauntEffect

extends CombatEffect

const effect_id = effect_type.TAUNT

@export var duration : float
var backup
var timer : Timer

func apply(entity : BaseEntity):
	backup = entity.target_data.current
	#this line of code is the only one that changes between this
	entity.target_data.current = casted_from
	# and slow effect so how do we deal about it
	casted_on = entity
	effect_is_active = true
	
	timer = Timer.new()
	timer.wait_time = duration 
	timer.timeout.connect(_on_timer_timeout)
	timer.autostart = true
	add_child(timer)
	entity.active_effects.append(self)
	entity.add_child(self)

func _on_timer_timeout():
	casted_on.target_data.current = backup
	end_effect()
