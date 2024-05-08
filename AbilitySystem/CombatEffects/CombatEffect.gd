class_name CombatEffect

extends Node

#@export_flags("Knockback", "DOT", "Slow", "True") var effects = 0
#@export var list : Array[effect_flags]
@export var effect_damage : float
@export var effect_power : float
var casted_from : BaseEntity
var casted_on : BaseEntity
var effect_is_active := false

enum effect_type {HEALTH, KNOCKBACK, SLOW, TAUNT}
#var flags : int

func _ready():
	if effect_is_active == false:
		#queuefree somehow later
		pass

func apply(entity : BaseEntity):
	pass
