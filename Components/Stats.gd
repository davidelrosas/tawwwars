class_name Stats

var owner_entity : BaseEntity
#Base Stats
var max_health : float
var movement_speed : float

var detection_range : float
var detection_mode : DetectionArea.detection_mode
# these ones will be more specific eventually
var armor : float
var ability_damage : float

#Current Stats
var current_health : float
var current_speed : float
#modifier dictionary

#modifier lists
var mul_modifiers : Array
var add_modifiers : Array

#we need to think about how this will work with different kinds of stats etc
# the maths are wrong, remake them
func apply_modifier(effect_id : CombatEffect.effect_type, reduction_factor : float):
	fill_modifiers(effect_id)
	
	var compound_modifier = 0
	print(mul_modifiers)
	if mul_modifiers != []:
		mul_modifiers.sort()
		var incremental_modifiers = mul_modifiers.filter(func(x): return x > 0)
		var decremental_modifiers = mul_modifiers.filter(func(x): return x < 0)
		var max = incremental_modifiers.pop_back() if incremental_modifiers != [] else 0
		var min = decremental_modifiers.pop_front() if decremental_modifiers != [] else 0
		
		var modifier_function = func(acc, x): return acc + ((x + (acc*x)) * reduction_factor)
		compound_modifier = incremental_modifiers.reduce(modifier_function, max) + decremental_modifiers.reduce(modifier_function, min)
		print(compound_modifier,"hello")
	match effect_id:
		CombatEffect.effect_type.MOVEMENT:
			
			current_speed = movement_speed * (1 + compound_modifier) + add_modifiers.reduce((func(acc,b): acc + b), 0)
			print(current_speed)
	
func fill_modifiers(effect_id : CombatEffect.effect_type):
	var same_type_effects = owner_entity.active_effects[effect_id]
	mul_modifiers = same_type_effects.filter(func(x): return x.modifier == CombatEffect.modifier_type.MULTIPLICATIVE).map(func(x): return x.effect_power/100)
	add_modifiers = same_type_effects.filter(func(x): return x.modifier == CombatEffect.modifier_type.ADDITIVE).map(func(x): return x.effect_power)

func remove_modifier():
	pass

@warning_ignore("shadowed_variable")
func _init(max_health : float, detection_range : float, detection_mode : DetectionArea.detection_mode, armor : float, ability_damage : float, movement_speed : float = 0):
	self.max_health = max_health
	self.current_health = max_health
	self.detection_range = detection_range
	self.detection_mode = detection_mode
	self.armor = armor
	self.ability_damage = ability_damage
	self.movement_speed = movement_speed
	self.current_speed = movement_speed
