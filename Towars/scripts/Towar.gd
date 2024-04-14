class_name Towar

extends BaseEntity

# Towar models
enum towar_model {TURRET,HEALER,WALL}

#variables
var key_bind : ActionSetFinder.ActionSet

func _input(event):
	if event.is_action_pressed(ActionSetFinder.actionSetDict[key_bind]):
		active.action(target_data,self)


# provides metadata on Towar models
static func get_info(model : towar_model, entry : String):
	var meta = Towar.new(model)
	match entry:
		"Name":
			return meta.metadata.displayname
		"Description":
			return meta.metadata.description
		"Cost":
			return str(meta.metadata.cost)
		"Icon":
			return meta.metadata.icon



#class constructor 
func _init(model : towar_model):
	
	#TOWAR MODELS
	match model:
		towar_model.TURRET:
			stats = Stats.new(100,50,20,15)
			metadata = Metadata.new(&"Basic Turret", "It shoots", 200, preload("res://Towars/Sprites/watch_tower.svg"))
			appearence = preload("res://Towars/prefabs/turret.tscn").instantiate()
			team = team_id.PLAYER
			active = load(Action.script_paths[Action.action_list.SIMPLESHOT]).new()
			key_bind = ActionSetFinder.ActionSet.ACTION_SET_1
			
		towar_model.HEALER:
			stats = Stats.new(70,50,15,15)
			metadata = Metadata.new(&"Healer", "It Heals", 400, preload("res://Towars/Sprites/tower_round_flag.svg"))
			appearence = preload("res://Towars/prefabs/healer.tscn").instantiate()
			team = team_id.PLAYER
			active = load(Action.script_paths[Action.action_list.SIMPLESHOT]).new()
			key_bind = ActionSetFinder.ActionSet.ACTION_SET_1
			
			
		towar_model.WALL:
			stats = Stats.new(200,30,50,15)
			metadata = Metadata.new(&"Basic Wall", "It's just there", 500, preload("res://Towars/Sprites/tower_square.svg"))
			appearence = preload("res://Towars/prefabs/wall.tscn").instantiate()
			team = team_id.PLAYER
			active = load(Action.script_paths[Action.action_list.SIMPLESHOT]).new()
			key_bind = ActionSetFinder.ActionSet.ACTION_SET_1
	
	#ASSEMBLING NODE TREE
	super._init()
	
