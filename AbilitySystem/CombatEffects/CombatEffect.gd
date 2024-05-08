class_name CombatEffect

extends Resource

#@export_flags("Knockback", "DOT", "Slow", "True") var effects = 0
#@export var list : Array[effect_flags]
@export var effect_damage : float
@export var effect_power : float
var casted_from : BaseEntity
var casted_on : BaseEntity
var effect_is_active := false

#enum effect_flags {KNOCKBACK, DOT, SLOW, TRUE}
#var flags : int

func apply(entity : BaseEntity):
	pass
