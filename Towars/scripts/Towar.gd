class_name Towar

extends BaseEntity

# Towar models
@export var model : towar_model
enum towar_model {TURRET,HEALER,WALL}

#variables
var key_bind : InputManager.Combo
#const catalog = {
	#towar_model.TURRET : preload("res://Towars/prefabs/turret.tscn"),
	#towar_model.HEALER : preload("res://Towars/prefabs/healer.tscn"),
	#towar_model.WALL : preload("res://Towars/prefabs/wall.tscn")
#}

#call super._ready() first if you want to use
func _ready():
	construct(model)
	super.set_properties()

func _input(event):
	if event.is_action_pressed("Use"): #temporary
		active.action(target_data,self)

#static func get_info(model : towar_model, entry : String):
	#match entry:
		#"Name":
			#return catalog[model].instantiate().metadata.displayname
		#"Description":
			#return catalog[model].instantiate().metadata.description
		#"Cost":
			#return str(catalog[model].instantiate().metadata.cost)
		#"Icon":
			#return catalog[model].instantiate().metadata.metadata.icon
	

#class constructor 
func construct(model_id : towar_model):
	#TOWAR MODELS
	match model_id:
		towar_model.TURRET:
			stats = Stats.new(100,500,DetectionArea.detection_mode.ENEMIESONLY,20,10)
			metadata = Metadata.new(&"Basic Turret", "It shoots", 200, preload("res://Towars/Sprites/watch_tower.svg"))
			team = team_id.PLAYER
			active = load(Action.script_paths[Action.action_list.SIMPLESHOT]).new()
			
		towar_model.HEALER:
			stats = Stats.new(70,500,DetectionArea.detection_mode.ALLIESONLY,15,10)
			metadata = Metadata.new(&"Healer", "It Heals", 400, preload("res://Towars/Sprites/tower_round_flag.svg"))
			team = team_id.PLAYER
			active = load(Action.script_paths[Action.action_list.AREAHEAL]).new()
			
		towar_model.WALL:
			stats = Stats.new(200,300,DetectionArea.detection_mode.ENEMIESONLY,50,10)
			metadata = Metadata.new(&"Basic Wall", "It's just there", 500, preload("res://Towars/Sprites/tower_square.svg"))
			team = team_id.PLAYER
			active = load(Action.script_paths[Action.action_list.TAUNT]).new()
