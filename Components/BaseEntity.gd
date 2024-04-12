extends Node2D

class_name BaseEntity

#Base Entity Building Blocks

# Information about entity and functionality
var stats : Stats
var metadata : Metadata
var active : Action
var passive : Action

#Node Part of the Entity
var appearence : CollisionObject2D #Has A Child called Healthbar

#Targeting System
var target_data := Target.new()

#region Health management functions
func effect(effect : HealthEffect):
	self.get_meta(&"HealthComponent").value = min(self.get_meta(&"HealthComponent").value - effect.power, self.get_meta(&"HealthComponent").max_value)
	if effect.power > 0:
		damage(effect)
	
	else:
		heal(effect)
	
#damage function
func damage(attack: HealthEffect):
	if self.get_meta(&"HealthComponent").value <= 0:
		death()

#heal function
func heal(heal: HealthEffect):
	pass

# death function
func death():
	SignalBus.death.emit(self)
	queue_free()
#endregion
