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

func _check_overlap(entity):
	if has_overlapping_bodies() && get_overlapping_bodies().has(entity) && !owner_entity.target_data.in_range.has(entity):
			owner_entity.target_data.in_range.append(entity)

@warning_ignore("shadowed_variable")
func set_properties(detection_range : float, mode : detection_mode = detection_mode.ENEMIESONLY,):
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
	SignalBus.entity_entered_tree.connect(_check_overlap)
