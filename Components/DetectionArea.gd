class_name DetectionArea

extends Area2D

enum detection_mode {ENEMIESONLY, ALLIESONLY, ALLENTITIES}
var owner_entity : BaseEntity
var radius : float
var mode : detection_mode

func _entered_range(entity):
	if entity != owner_entity:
		owner_entity.target_data.in_range.append(entity)
		print(str(owner_entity.model))
		print(owner_entity.target_data.in_range)

func _exited_range(entity):
	if owner_entity.target_data.in_range.has(entity):
		owner_entity.target_data.in_range.erase(entity)
		if owner_entity.target_data.current == entity:
			owner_entity.target_data.current = null 
	print(str(owner_entity.model))
	print(owner_entity.target_data.in_range)

#func _check_overlap(entity):
	#seems obsolete, entities are entering list despite being spawned on top of others  
	# right now it calculates from center to center, more complex if we take collision shape into account
	#var dif_vector = global_position - entity.global_position
	#var condition_1 = sqrt(pow((dif_vector).x,2) + pow((dif_vector).y,2)) < radius
	#var condition_2 = has_overlapping_bodies() && get_overlapping_bodies().has(entity) && !owner_entity.target_data.in_range.has(entity)
	#print(dif_vector)
	#print(condition_1)
	#print(condition_2)
	#if condition_1 && condition_2:
		#owner_entity.target_data.in_range.append(entity)

@warning_ignore("shadowed_variable")
func set_properties(detection_range : float, mode : detection_mode = detection_mode.ENEMIESONLY):
	radius = detection_range
	get_node("CollisionShape2D").shape.radius = radius
	self.mode = mode
	match mode:
		detection_mode.ENEMIESONLY:
			if owner_entity.team == BaseEntity.team_id.PLAYER:
				collision_mask = 16
			else: 
				collision_mask = 8
		detection_mode.ALLIESONLY:
			if owner_entity.team == BaseEntity.team_id.PLAYER:
				collision_mask = 8
			else: 
				collision_mask = 16
		detection_mode.ALLENTITIES:
			collision_mask = 0b11000
			
	body_entered.connect(_entered_range)
	body_exited.connect(_exited_range)
	#SignalBus.entity_entered_tree.connect(_check_overlap)
