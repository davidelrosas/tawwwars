class_name Stats

var max_health : float
var detection_range : float

#for mobs only?
var movement_speed : float

#should the entity have a stat for how the stat is supposed to look and on for how it currently looks? modified?
#Not sure if this should be here at all probably should be done by abilities depending 
#on which ability an entity casts, or the detection range has a list for ally and for enemy units
var detection_mode : DetectionArea.detection_mode

# these ones will be more specific eventually
var armor : float
var ability_modifier : float

#Temporary modified stats (stack)
var movement_speed_backup = []

func apply_modifier():
	pass

func remove_modifier():
	pass

@warning_ignore("shadowed_variable")
func _init(max_health : float, detection_range : float, detection_mode : DetectionArea.detection_mode, armor : float, ability_modifier : float):
	self.max_health = max_health
	self.detection_range = detection_range
	self.detection_mode = detection_mode
	self.armor = armor
	self.ability_modifier = ability_modifier
