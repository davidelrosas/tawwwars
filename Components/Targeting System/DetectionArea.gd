class_name DetectionArea

extends Area2D

enum detection_mode {ENEMIESONLY, ALLIESONLY, ALLENTITIES}
var owner_entity : BaseEntity
var radius : float
var mode : detection_mode
# we are gonna need to rework this maybe combine it with hitbox maybe not
# but definetely make some of this functionality available for abilities


func _entered_range(entity):
	print(owner_entity.target_data.in_range)
	if entity != owner_entity:
		owner_entity.target_data.in_range.append(entity)

func _exited_range(entity):
	if owner_entity.target_data.in_range.has(entity):
		owner_entity.target_data.in_range.erase(entity)
		if owner_entity.target_data.current_targets.has(entity):
			owner_entity.target_data.current_targets.erase(entity)
			#and here probably run the Target function targets_ready(): again
			#or also if a target Dies inside the detection range, we should connect to
			# the death signal

func _check_overlap(entity):
	var dif_vector = global_position - entity.global_position
	#+ find good arbitrary number
	var condition_1 = sqrt(pow((dif_vector).x,2) + pow((dif_vector).y,2)) < radius
	#some shit is not working here
	print(get_overlapping_bodies(),"hello")
	var condition_2 = has_overlapping_bodies() && get_overlapping_bodies().has(entity) && !owner_entity.target_data.in_range.has(entity)
	print(dif_vector)
	print(condition_1)
	print(condition_2)
	if condition_1 && condition_2:
		owner_entity.target_data.in_range.append(entity)

@warning_ignore("shadowed_variable")
func set_properties(detection_range : float, mode : detection_mode = detection_mode.ENEMIESONLY):
	radius = detection_range
	get_node("CollisionShape2D").shape.radius = radius
	collision_layer = 0
	self.mode = mode
	match mode:
		detection_mode.ENEMIESONLY:
			if owner_entity.team_id == BaseEntity.team.PLAYER:
				collision_mask = 16
			else: 
				collision_mask = 8
		detection_mode.ALLIESONLY:
			if owner_entity.team_id == BaseEntity.team.PLAYER:
				collision_mask = 8
			else: 
				collision_mask = 16
		detection_mode.ALLENTITIES:
			collision_mask = 0b11000
			
	body_entered.connect(_entered_range)
	body_exited.connect(_exited_range)
	SignalBus.entity_entered_scene.connect(_check_overlap)
