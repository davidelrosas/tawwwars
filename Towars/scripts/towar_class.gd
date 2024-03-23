class_name Towar

# Inheritance

extends StaticBody2D

#Member variables

var max_health : float
var current_health : float
var towar_range : float
var resistances = [0,0]


# Constants

# Enums

enum towar_type {attack_towar,healing_towar,defense_towar}

# Functions

# effect function
func effect_towar(effect : HealthEffect):
	current_health = min(current_health+effect.power, max_health)
	$HealthBar.value = current_health
	
	if effect.power > 0:
		takes_damage(effect)
	
	else:
		receives_heal(effect)
	

#damage function
func takes_damage(attack: HealthEffect):
	if current_health <= 0:
		death()

#heal function
func receives_heal(heal: HealthEffect):
	pass

# death function
func death():
		SignalBus.towar_death.emit(self)
		queue_free()

# action function
func action():
	pass



#class constructor
func towar_constructor(max_health1, towar_range1, resistances1, towar_type1):
	max_health = max_health1
	current_health = max_health1
	
	$HealthBar.max_value = max_health
	$HealthBar.value = max_health
