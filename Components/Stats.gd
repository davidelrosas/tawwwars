class_name Stats

var owner_entity : BaseEntity
#Base Stats

#Current Stats

#modifier dictionary
#maybe multiplicative and maybe additive (2 lists)
var mul_modifiers : Array[float]
var add_modifiers : Array[float]

var max_health : float
var current_health : float

var detection_range : float

#for mobs only?
var movement_speed : float
var current_speed : float
var movement_speed_modifiers : Array[float]

var detection_mode : DetectionArea.detection_mode

# these ones will be more specific eventually
var armor : float
var ability_modifier : float


#we need to think about how this will work with different kinds of stats etc
# the maths are wrong, remake them
func apply_modifier(effect_id : CombatEffect.effect_type, reduction_factor : float):
	fill_modifiers(effect_id)
	
	mul_modifiers.sort()
	var incremental_modifiers = mul_modifiers.filter(func(x): x > 0)
	var decremental_modifiers = mul_modifiers.filter(func(x): x < 0)
	var max = incremental_modifiers.pop_back()
	var min = decremental_modifiers.pop_front()
	
	var modifier_function = func(acc, x): acc * (1 + (x*reduction_factor))
	# can pop be done inside reduce? will it pop first and then eliminate it out of modifier_lists?
	var compound_modifier = incremental_modifiers.reduce(modifier_function, (1 + max)) - incremental_modifiers.reduce(modifier_function, (1 + min))
	current_speed = movement_speed * compound_modifier + add_modifiers.reduce((func(acc,b): acc + b), 0)
	
func fill_modifiers(effect_id : CombatEffect.effect_type):
	var same_type_effects = owner_entity.active_effects[effect_id]
	mul_modifiers = same_type_effects.filter(func(x): x.modifier == CombatEffect.modifier_type.MULTIPLICATIVE)
	add_modifiers = same_type_effects.filter(func(x): x.modifier == CombatEffect.modifier_type.ADDITIVE)
	mul_modifiers.map(func(x):(x.effect_power/100))

func remove_modifier():
	pass

@warning_ignore("shadowed_variable")
func _init(max_health : float, detection_range : float, detection_mode : DetectionArea.detection_mode, armor : float, ability_modifier : float):
	self.max_health = max_health
	self.current_health = max_health
	self.detection_range = detection_range
	self.detection_mode = detection_mode
	self.armor = armor
	self.ability_modifier = ability_modifier
