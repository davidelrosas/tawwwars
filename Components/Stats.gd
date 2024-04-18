class_name Stats

var max_health : float
var detection_range : float
var detection_mode : DetectionArea.detection_mode
var armor : float
var ability_modifier : float

@warning_ignore("shadowed_variable")
func _init(max_health : float, detection_range : float, detection_mode : DetectionArea.detection_mode, armor : float, ability_modifier : float):
	self.max_health = max_health
	self.detection_range = detection_range
	self.detection_mode = detection_mode
	self.armor = armor
	self.ability_modifier = ability_modifier
