class_name BaseEntity

extends CharacterBody2D

#Node Part of the Entity
@export var healthbar : Healthbar
@export var hurtbox : HurtBox
@export var det_area : DetectionArea
#exports

# Information about entity and functionality
var stats : Stats
var active : Action
var passive : Action

#Targeting System
var target_data := Target.new()
var team : team_id

enum team_id {PLAYER, ENEMY}

#func _enter_tree():
	#SignalBus.entity_entered_tree.emit(self)

#region Health management functions
func effect(health_effect : HealthEffect):
	healthbar.value = min(healthbar.value - health_effect.power, healthbar.max_value)
	if health_effect.power > 0:
		takes_damage(health_effect)
	
	else:
		receives_heal(health_effect)

#damage function
func takes_damage(attack: HealthEffect):
	if healthbar.value <= 0:
		death()

#heal function
func receives_heal(heal: HealthEffect):
	pass

# death function
func death():
	SignalBus.death.emit(self)
	queue_free()
#endregion

func set_properties():
	#Setting Healthbar
	healthbar.max_value = stats.max_health
	healthbar.value = stats.max_health
	
	#connecting Hurtbox
	hurtbox.owner_entity_ref = self
	hurtbox.set_layer(team)
	
	if team == team_id.PLAYER:
		collision_layer = 0b01001
	else:
		collision_layer = 0b10001
		
	#creating detection range radius
	det_area.owner_entity = self
	det_area.set_properties(stats.detection_range, stats.detection_mode)
