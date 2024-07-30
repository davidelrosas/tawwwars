class_name Mob

extends BaseEntity

# Mob types
@export var type : mob_type
enum mob_type {ALLEN, BOSSMAN}

const acceleration = 5

var navAgent = NavigationAgent2D.new()
var posManapool : Vector2

func _ready():
	construct(type)
	stats.current_speed = stats.movement_speed
	super.set_properties()
	NavigationAgent2D
	add_child(navAgent)
	velocity = Vector2.ZERO
	
	#super._ready()

#temporary af
func _physics_process(delta):
	
	var separation : Vector2
	const w_separation : float = 0.0
	var alignment : Vector2
	const w_alignment : float = 0.0
	var cohesion : Vector2
	const w_cohesion : float = 0.0
	var goal : Vector2
	const w_goal : float = 1.0

	navAgent.target_position = posManapool if target_data.in_range.is_empty() else target_data.in_range[0].position

	var peenus = navAgent.get_next_path_position()
	print(peenus)
	goal = (peenus - global_position).normalized()
	$Sprite2D.look_at(goal)
	
	var cf_dot = 1 - goal.dot(-velocity)
	var counterforcedir : Vector3 = Vector3(goal.x,goal.y,0).cross(Vector3(0,0,sign(goal.cross(velocity))))
	var counterforce : Vector2 = Vector2(counterforcedir.x,counterforcedir.y).normalized() * (cf_dot)
	const w_counterforce : float = 0.0
		
	var force : Vector2 = goal * w_goal + counterforce * w_counterforce
	velocity += force * delta * acceleration
	if (velocity.length_squared() > stats.current_speed*stats.current_speed):
		velocity = velocity.normalized()*stats.current_speed
	move_and_slide()

#class constructor 
func construct(type : mob_type):
	#MOB TYPES
	match type:
		mob_type.ALLEN:
			stats = Stats.new(20,2000,DetectionArea.detection_mode.ENEMIESONLY,10,0,100)
			team_id = team.ENEMY
			
		mob_type.BOSSMAN:
			stats = Stats.new(200,2000,DetectionArea.detection_mode.ENEMIESONLY,50,0,50)
			team_id = team.ENEMY
