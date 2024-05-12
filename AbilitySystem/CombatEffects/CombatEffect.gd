class_name CombatEffect

extends Node

#@export_flags("Knockback", "DOT", "Slow", "True") var effects = 0
#@export var list : Array[effect_flags]
@export var effect_power : float
var casted_from : BaseEntity
var applied_on : BaseEntity

enum effect_type {HEALTH, KNOCKBACK, MOVEMENT, TAUNT}
#var flags : int

func apply(entity : BaseEntity):
	#entity = applied_on -> important step for all apply functions
	pass

func end_effect():
	print(applied_on.active_effects)
	applied_on.active_effects[self.effect_id].erase(self)
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

#to get the list of active effects of a certain type
# why cant it be array of combat effects but it has to be specific to the subclass???
func get_effects(effect_type : CombatEffect.effect_type) -> Array:
	return applied_on.active_effects[effect_type]

func initialize_effect(caster : BaseEntity):
	casted_from = caster

func _on_timer_timeout():
	end_effect()
