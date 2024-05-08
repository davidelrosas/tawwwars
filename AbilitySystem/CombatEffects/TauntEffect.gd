class_name TauntEffect

extends CombatEffect

const effect_id = effect_type.TAUNT

@export var duration : float
var backup
var timer : Timer

func apply(entity : BaseEntity):
	backup = entity.target_data.current
	entity.target_data.current = casted_from
	casted_on = entity
	effect_is_active = true
	
	timer = Timer.new()
	timer.wait_time = duration 
	timer.timeout.connect(_on_timer_timeout)
	timer.autostart = true
	add_child(timer)

func _on_timer_timeout():
	queue_free()
	casted_on.target_data.current = backup
