class_name Mob

extends BaseEntity

# Mob types
@export var type : mob_type
enum mob_type {ALLEN, BOSSMAN}

var ai

func _ready():
	construct(type)
	super.set_properties()

#class constructor 
func construct(type : mob_type):
	
	#MOB TYPES
	match type:
		mob_type.ALLEN:
			stats = Stats.new(20,100,DetectionArea.detection_mode.ENEMIESONLY,10,0)
			team = team_id.ENEMY
			
		mob_type.BOSSMAN:
			stats = Stats.new(200,500,DetectionArea.detection_mode.ENEMIESONLY,50,0)
			team = team_id.ENEMY
