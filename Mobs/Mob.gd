class_name Mob

extends BaseEntity

# Mob types
enum mob_type {ALLEN, BOSSMAN}

var ai

func _ready():
	appearence.target = target_data

#class constructor 
func _init(model : mob_type):
	
	#MOB TYPES
	match model:
		mob_type.ALLEN:
			stats = Stats.new(20,100,DetectionArea.detection_mode.ENEMIESONLY,10,0)
			metadata = Metadata.new(&"Allen", "greatest guy in the universe", 400, preload("res://Towars/Sprites/tower_round_flag.svg"))
			appearence = preload("res://Mobs/allen.tscn").instantiate()
			team = team_id.ENEMY
			
		mob_type.BOSSMAN:
			stats = Stats.new(200,500,DetectionArea.detection_mode.ENEMIESONLY,50,0)
			metadata = Metadata.new(&"Bossman", "scary guy", 400, preload("res://Towars/Sprites/tower_round_flag.svg"))
			appearence = preload("res://Mobs/bossman.tscn").instantiate()
			team = team_id.ENEMY
	
	#ASSEMBLING NODE TREE of Entity
	super._init()
	
