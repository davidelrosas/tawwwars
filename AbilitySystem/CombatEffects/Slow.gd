class_name SlowEffect

extends CombatEffect

@export var duration : float
var backup

func apply(entity : BaseEntity):
	backup = entity.movement_speed
	casted_on = entity
	entity.movement_speed *= max((100-effect_power)/100, 0)
	var timer = Timer.new()
	timer.wait_time = duration 
	timer.timeout.connect(_on_timer_timeout)
	entity.add_child(timer)
	pass

func _on_timer_timeout():
	casted_on.movement_speed = backup
	pass
