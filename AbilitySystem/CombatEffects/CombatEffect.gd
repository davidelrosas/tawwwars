class_name CombatEffect

extends Resource

#@export_flags("Knockback", "DOT", "Slow", "True") var effects = 0
#@export var list : Array[effect_flags]
@export var effect_damage : float
@export var effect_power : float

#enum effect_flags {KNOCKBACK, DOT, SLOW, TRUE}
#var flags : int

func apply(entity : BaseEntity):
	pass
