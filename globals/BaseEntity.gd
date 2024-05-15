class_name BaseEntity

extends CharacterBody2D

#Node Part of the Entity
@export var healthbar : Healthbar
@export var hurtbox : HurtBox
@export var det_area : DetectionArea
#exports

# Entity stats and abilities
var stats : Stats

var active : PackedScene
var passive : Action

# key is effect_type id and entry an array with all the active effects of that type
var active_effects : Dictionary

#Targeting System
var target_data := Target.new()
var team_id : team

enum team {PLAYER, ENEMY}

#func _ready():
	#SignalBus.entity_entered_scene.emit(self)

#region Health management functions
func effect(effects_list : Array[CombatEffect]):
	#initialize_combat_effects(effects_list, self)
	for i in effects_list:
		#if effect_not_active_or_greater(i) == true:
		var effect = i.duplicate()
		effect.apply(self)
			
		print(active_effects)
	if stats.current_health <= 0:
		death()
	healthbar.value = stats.current_health

# death function
func death():
	SignalBus.death.emit(self)
	queue_free()
#endregion

func set_properties():
	#setting stats
	stats.owner_entity = self
	#Setting Healthbar
	healthbar.max_value = stats.max_health
	healthbar.value = stats.max_health
	#connecting Hurtbox
	hurtbox.owner_entity = self
	hurtbox.set_layer(team_id)
	
	if team_id == team.PLAYER:
		collision_layer = 0b01001
	else:
		collision_layer = 0b10001
		
	#setting targeting system
	target_data.owner_entity = self
	det_area.owner_entity = self
	det_area.set_properties(stats.detection_range, stats.detection_mode)
	#active
