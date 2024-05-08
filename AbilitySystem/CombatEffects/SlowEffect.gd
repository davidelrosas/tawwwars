class_name SlowEffect

extends CombatEffect

const effect_id = effect_type.SLOW

@export var duration : float
var backup
var timer : Timer

func apply(entity : BaseEntity):
	backup = entity.movement_speed
	casted_on = entity
	entity.movement_speed *= max((100-effect_power)/100, 0)
	effect_is_active = true
	
	timer = Timer.new()
	timer.wait_time = duration 
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

func _on_timer_timeout():
	print(timer)
	queue_free()
	casted_on.movement_speed = backup
	print(backup)
