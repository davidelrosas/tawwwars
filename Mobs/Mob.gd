class_name Mob

extends BaseEntity

# Mob types
@export var type : mob_type
enum mob_type {ALLEN, BOSSMAN}

var ai

func _ready():
	super._ready()
	pass

#class constructor 
func _init(model : mob_type):
	
	#MOB TYPES
	match model:
		mob_type.ALLEN:
			stats = Stats.new(20,100,DetectionArea.detection_mode.ENEMIESONLY,10,0)
			metadata = Metadata.new(&"Allen", "greatest guy in the universe", 400, preload("res://Towars/Sprites/tower_round_flag.svg"))
			team = team_id.ENEMY
			
		mob_type.BOSSMAN:
			stats = Stats.new(200,500,DetectionArea.detection_mode.ENEMIESONLY,50,0)
			metadata = Metadata.new(&"Bossman", "scary guy", 400, preload("res://Towars/Sprites/tower_round_flag.svg"))
			team = team_id.ENEMY
