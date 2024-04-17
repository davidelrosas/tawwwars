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
var healthbar : Control
var hurtbox : HurtBox
var det_area : DetectionArea

#Targeting System
var target_data := Target.new()
var team : team_id

enum team_id {PLAYER, ENEMY}

func _enter_tree():
	SignalBus.entity_entered_tree.emit(self)

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

#Constructor only to be called by subclasses
func _init():
	#Setting Healthbar
	healthbar = appearence.get_node("Healthbar")
	healthbar.max_value = stats.max_health
	healthbar.value = stats.max_health
	
	#connecting Hurtbox
	hurtbox = appearence.get_node("HurtBox")
	hurtbox.owner_entity_ref = self
	hurtbox.set_layer(team)
	
	#making appearence be in the correct layers
	if appearence is RigidBody2D:
		appearence.gravity_scale = 0
	
	if team == team_id.PLAYER:
		appearence.collision_layer = 0b01001
	else:
		appearence.collision_layer = 0b10001
		
	#creating detection range radius
	det_area = DetectionArea.new(stats.detection_range)
	det_area.owner_entity = self
	det_area.set_layer(stats.detection_mode)
	appearence.add_child(det_area)
	add_child(appearence)
	
