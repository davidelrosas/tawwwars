class_name CombatEffect

extends Node

#what if i make a spread combateffect instead of making it part of ability functionality?
@export var effect_power : float
var casted_from : BaseEntity
var applied_on : BaseEntity

enum effect_type {HEALTH, KNOCKBACK, MOVEMENT, TAUNT}
enum modifier_type {ADDITIVE,MULTIPLICATIVE}

func apply(_entity : BaseEntity):
	#entity = applied_on -> important step for all apply functions
	pass

func end_effect():
	queue_free()

func set_timer(duration : float):
	var timer = Timer.new()
	timer.wait_time = duration 
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	pass

func activate_effect():
	if !applied_on.active_effects.has(self.effect_id):
		applied_on.active_effects[self.effect_id] = [self]
	else:
		applied_on.active_effects[self.effect_id].append(self)
	applied_on.add_child(self)

func initialize_effect(caster : BaseEntity):
	casted_from = caster

func _on_timer_timeout():
	end_effect()
