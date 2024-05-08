class_name TauntEffect

extends CombatEffect

@export var duration : float
var backup

func apply(entity : BaseEntity):
	backup = entity.target_data.current
	entity.target_data.current = casted_from
	
	var timer := Timer.new()
	timer.wait_time = duration 
	timer.timeout.connect(_on_timer_timeout)
	timer.autostart = true
	entity.add_child(timer)

func _on_timer_timeout():
	casted_on.target_data.current = backup
