class_name SlowEffect

extends CombatEffect

@export var duration : float


func apply(entity : BaseEntity):
	var backup = entity.movement_speed
	entity.movement_speed -= effect_power
	var timer = Timer.new()
	timer.wait_time = duration 
	timer.timeout.connect(_on_timer_timeout(entity))
	entity.add_child(timer)
	pass

func _on_timer_timeout(entity):
	pass
