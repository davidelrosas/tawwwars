class_name Mob

extends BaseEntity

# Mob types
@export var type : mob_type
enum mob_type {ALLEN, BOSSMAN}

var ai
var movement_speed : float = 50
var direction : Vector2

func _ready():
	construct(type)
	super.set_properties()


func _physics_process(delta):
	if target_data.current:
		look_at(target_data.current.global_position)
		direction = (target_data.current.global_position - global_position).normalized()
		global_position += direction * movement_speed * delta

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
