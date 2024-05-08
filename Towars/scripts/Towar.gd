class_name Towar

extends BaseEntity

# Towar models
@export var model : towar_model
enum towar_model {TURRET,HEALER,WALL}

#variables
var key_bind : InputManager.Combo

#catalog with metadata for shop or others
static var catalog = {
	towar_model.TURRET : Metadata.new(&"Basic Turret", "It shoots", 200, preload("res://Towars/Sprites/watch_tower.svg")),
	towar_model.HEALER : Metadata.new(&"Healer", "It Heals", 400, preload("res://Towars/Sprites/tower_round_flag.svg")),
	towar_model.WALL : Metadata.new(&"Basic Wall", "It's just there", 500, preload("res://Towars/Sprites/tower_square.svg"))
}

func _ready():
	construct(model)
	super.set_properties()

func _input(event):
	if event.is_action_pressed("Use"): #temporary
		var ability_instance = active.instantiate()
		ability_instance.cast(target_data, self)

#get metadata about a specific towar
static func get_info(model : towar_model, entry : String):
	match entry:
		"Name":
			return catalog[model].displayname
		"Description":
			return catalog[model].description
		"Cost":
			return str(catalog[model].cost)
		"Icon":
			return catalog[model].icon
	

#model constructor 
func construct(model_id : towar_model):
	#TOWAR MODELS
	match model_id:
		towar_model.TURRET:
			stats = Stats.new(100,500,DetectionArea.detection_mode.ENEMIESONLY,20,10)
			team_id = team.PLAYER
			active = preload("res://AbilitySystem/AllAbilities/simple_homing_bullet.tscn")
			
		towar_model.HEALER:
			stats = Stats.new(70,500,DetectionArea.detection_mode.ALLIESONLY,15,10)
			team_id = team.PLAYER
			active = preload("res://AbilitySystem/AllAbilities/simple_heal.tscn")
			
		towar_model.WALL:
			stats = Stats.new(200,300,DetectionArea.detection_mode.ENEMIESONLY,50,10)
			team_id = team.PLAYER
			active = preload("res://AbilitySystem/AllAbilities/goo_puddle.tscn")
