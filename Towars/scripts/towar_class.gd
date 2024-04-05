class_name Towar

extends Node

#Member variables

#Towar Propperties
var max_health : float
var current_health : float
var towar_range : float
var resistances = [0,0]


# Constants

# Towar Subclasses

enum towar_type {ATTACK,HEALING,DEFENSE}

const script_paths = {
	towar_type.ATTACK : "res://Towars/scripts/attack_towar_subclass.gd",
	towar_type.HEALING : "res://Towars/scripts/healing_towar_subclass.gd",
	towar_type.DEFENSE : "res://Towars/scripts/defense_towar_subclass.gd"
}

# Functions

#region BASE TOWAR FUNCTIONALITY
func effect(effect : HealthEffect):
	current_health = min(current_health - effect.power, max_health)
	
	
	if effect.power > 0:
		takes_damage(effect)
	
	else:
		receives_heal(effect)
	

#damage function
func takes_damage(attack: HealthEffect):
	if current_health <= 0:
		pass

#heal function
func receives_heal(heal: HealthEffect):
	pass

# death function maybe useless
func death():
		SignalBus.towar_death.emit(self)
		queue_free()

# action function
func action(something):
	pass
#endregion

#class constructor 
func _init(max_health1, towar_range1, resistances1):
	max_health = max_health1
	current_health = max_health1
	resistances = resistances1
	towar_range = towar_range1
