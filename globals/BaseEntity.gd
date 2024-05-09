class_name BaseEntity

extends CharacterBody2D

#Node Part of the Entity
@export var healthbar : Healthbar
@export var hurtbox : HurtBox
@export var det_area : DetectionArea
#exports

# Information about entity and functionality
var stats : Stats
var active : PackedScene
var passive : Action

#resistances/ active effects
#maybe make this a node that holds the effects? (on the scene or make the node in code)
var active_effects : Array[CombatEffect]

#Targeting System
var target_data := Target.new()
var team_id : team

enum team {PLAYER, ENEMY}

#func _enter_tree():
	#SignalBus.entity_entered_tree.emit(self)

#region Health management functions
func effect(effects_list : Array[CombatEffect]):
	#initialize_combat_effects(effects_list, self)
	for i in effects_list:
		#probably later inside of takes functions depending on resistances and effects!!
		if effect_not_active_or_greater(i) == true:
			var effect = i.duplicate()
			effect.apply(self)
			
		print(self.stats.max_health)
		print(active_effects)
	if healthbar.value <= 0:
		death()

func effect_not_active_or_greater(effect) -> bool:
	var acc = true
	for i in active_effects:
		if effect.effect_id != i.effect_id || effect.effect_id == i.effect_id && effect.effect_power > i.effect_power:
			acc = true
		else:
			acc = false
	return acc
	

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
	hurtbox.set_layer(team_id)
	
	if team_id == team.PLAYER:
		collision_layer = 0b01001
	else:
		collision_layer = 0b10001
		
	#creating detection range radius
	det_area.owner_entity = self
	det_area.set_properties(stats.detection_range, stats.detection_mode)
