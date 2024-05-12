class_name Stats

#Base Stats

#Current Stats

#modifier dictionary
var modifiers : Array[float]

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
func apply_modifier(effect_id : CombatEffect.effect_type):
	modifiers.sort()
	# 30 should be a number that somone else gives
	var modifier_function = func(acc, x): acc + x*30
	var compound_modifier = modifiers.pop_front() + modifiers.pop_back() + modifiers.reduce(modifier_function, 0)/modifiers.size()
	current_speed = movement_speed * compound_modifier
	
func fill_modifiers(modifiers : Array[float]):
	self.modifiers = modifiers

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
