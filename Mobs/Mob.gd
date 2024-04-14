class_name Mob

extends BaseEntity

# Mob types
enum mob_type {ALLEN, BOSSMAN}

var AI

func _ready():
	pass


#class constructor 
func _init(model : mob_type):
	
	#MOB TYPES
	match model:
		mob_type.ALLEN:
			stats = Stats.new(20,10,10,0)
			appearence = preload("res://Mobs/allen.tscn").instantiate()
			team = team_id.ENEMY
			
		mob_type.BOSSMAN:
			stats = Stats.new(200,50,50,0)
			appearence = preload("res://Mobs/bossman.tscn").instantiate()
			team = team_id.ENEMY
	
	#ASSEMBLING NODE TREE of Entity
	super._init()
	
