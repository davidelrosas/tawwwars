class_name Mob

extends BaseEntity

# Towar Subclasses
enum hostile_mob {ALLEN, BOSSMAN}
enum friendly_mob {}
enum neutral_mob {}

var AI

func _ready():
	pass


#class constructor 
func _init(model : hostile_mob):
	
	#TOWAR MODELS
	match model:
		hostile_mob.ALLEN:
			stats = Stats.new(20,10,10,0)
			appearence = preload("res://Mobs/enemy.tscn").instantiate()
			team = team_id.ENEMY
			
		hostile_mob.BOSSMAN:
			stats = Stats.new(200,50,50,0)
			appearence = preload("res://Mobs/enemy.tscn").instantiate()
			team = team_id.ENEMY
	
	#ASSEMBLING NODE TREE of Entity
	super._init()
	
