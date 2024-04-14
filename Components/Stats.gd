class_name Stats

var max_health : float
var detection_range : float
var armor : float
var ability_modifier : float

func _init(max_health : float, detection_range : float, armor : float, ability_modifier : float):
	self.max_health = max_health
	self.detection_range = detection_range
	self.armor = armor
	self.ability_modifier = ability_modifier
