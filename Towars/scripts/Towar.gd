class_name Towar

extends BaseEntity

# Towar models
@export var model : towar_model
enum towar_model {TURRET,HEALER,WALL,OBELISK,GOO}

#variables
var key_bind : InputManager.Combo

#catalog with metadata for shop or others

func _ready():
	construct(model)
	super.set_properties()
	#super._ready()

func cast():
	var ability_cast = active.instantiate()
	ability_cast.owner_entity = self
	ability_cast.cast()

#model constructor 
#maybe do this with dictionary instead of match
func construct(model_id : towar_model):
	#TOWAR MODELS
	match model_id:
		towar_model.TURRET:
			stats = Stats.new(100,200,DetectionArea.detection_mode.ENEMIESONLY,20,10)
			team_id = team.PLAYER
			active = preload("res://AbilitySystem/Common/simple_homing_bullet.tscn")
			
		towar_model.HEALER:
			stats = Stats.new(70,200,DetectionArea.detection_mode.ALLIESONLY,15,10)
			team_id = team.PLAYER
			active = preload("res://AbilitySystem/Common/single_target_heal.tscn")
			
		towar_model.WALL:
			stats = Stats.new(200,200,DetectionArea.detection_mode.ENEMIESONLY,50,10)
			team_id = team.PLAYER
			active = preload("res://AbilitySystem/Common/area_taunt.tscn")
			
		towar_model.OBELISK:
			stats = Stats.new(150,200,DetectionArea.detection_mode.ENEMIESONLY,15,10)
			team_id = team.PLAYER
			active = preload("res://AbilitySystem/AllAbilities/exploding_shot.tscn")
			
		towar_model.GOO:
			stats = Stats.new(200,0,DetectionArea.detection_mode.ENEMIESONLY,20,10)
			team_id = team.PLAYER
			active = preload("res://AbilitySystem/AllAbilities/goo_puddle.tscn")
