class_name Mob

extends BaseEntity

# Mob types
@export var type : mob_type
enum mob_type {ALLEN, BOSSMAN}

var ai
var current_speed : float = 50
var direction : Vector2

func _ready():
	construct(type)
	current_speed = stats.movement_speed
	super.set_properties()
	super._ready()

#temporary af
func _physics_process(delta):
	if target_data.current_targets != null:
		if move_and_slide():
			direction = Vector2(randf_range(-1,1),randf_range(-1,1))
		else:
			direction = (target_data.current_targets.back().global_position - global_position).normalized()
		#needs to be fixed
		look_at(target_data.current_targets.back().global_position)
		global_position += direction * current_speed * delta

#class constructor 
func construct(type : mob_type):
	
	#MOB TYPES
	match type:
		mob_type.ALLEN:
			stats = Stats.new(20,100,DetectionArea.detection_mode.ENEMIESONLY,10,0)
			team_id = team.ENEMY
			stats.movement_speed = 100
			
		mob_type.BOSSMAN:
			stats = Stats.new(200,500,DetectionArea.detection_mode.ENEMIESONLY,50,0)
			team_id = team.ENEMY
			stats.movement_speed = 50
